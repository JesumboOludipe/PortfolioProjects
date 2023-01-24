/*

Covid 19 Data Exploration (01/01/2020 to 30/04/2021)

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

--Worldwide Covid Deaths 

SELECT *
FROM Portfolio..CovidDeaths
Where continent is not null
ORDER BY 3,4

--Worldwide Covid Vaccinations

SELECT *
FROM Portfolio..CovidVaccinations
ORDER BY 3,4

--Select data to start with

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM Portfolio..CovidDeaths
ORDER BY 1,2

--Total Deaths vs Total Cases
--Shows the likelihood of dieing if a person contract COVID in their country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate
FROM Portfolio..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

--Death rate with respect to total cases in Nigeria

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate
FROM Portfolio..CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2

--Total Cases vs Population
--Shows percentage of population that was infected with COVID 

SELECT location, date, Population, total_cases, (total_cases/Population)*100 as cases_percentage
FROM Portfolio..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2


--Countries with Highest infection rate compared to Population

SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/Population))*100 as percent_population_infected
FROM Portfolio..CovidDeaths
GROUP BY location, population
ORDER BY percent_population_infected desc

--Countries with Highest Death count with respect to Population

SELECT location, MAX(CAST(total_deaths as int)) as total_death_count
FROM Portfolio..CovidDeaths
Where continent is not null
GROUP BY location
ORDER BY total_death_count desc




--BREAKING THINGS DOWN BY CONTINENT

--Continents with the highest death count per population

SELECT location, MAX(CAST(total_deaths as int)) as total_death_count
FROM Portfolio..CovidDeaths
Where continent is null
GROUP BY location
ORDER BY total_death_count desc

--Continents with Highest infection rate compared to Population

SELECT location, population, MAX(total_cases) as highest_infection_count, 
MAX((total_cases/Population))*100 as percent_population_infected
FROM Portfolio..CovidDeaths
Where continent is null
GROUP BY location, population
ORDER BY percent_population_infected desc

--SELECT continent, MAX(CAST(total_deaths as int)) as total_death_count
--FROM Portfolio..CovidDeaths
--Where continent is not null
--GROUP BY continent
--ORDER BY total_death_count desc



--GLOBAL NUMBERS

--Global daily total deaths and death rates

SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_rate
FROM Portfolio..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

--Total deaths and Global death rates

SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_rate
FROM Portfolio..CovidDeaths
WHERE continent is not null
ORDER BY 1,2



--VACCINATIONS
--Join Covid Deaths Table with Covid Vaccinations Table

SELECT *
FROM Portfolio..CovidDeaths dea
JOIN Portfolio..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM Portfolio..CovidDeaths dea
JOIN Portfolio..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

--Rolling count of People Vaccinate
--USE CTE  to perform Calculation on Partition By in previous query

WITH PopvsVac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated) 
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by 
dea.location, dea.date) as rolling_people_vaccinated
FROM Portfolio..CovidDeaths dea
JOIN Portfolio..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3
)
SELECT *, (rolling_people_vaccinated/population)*100 
FROM PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by 
dea.location, dea.date) as RollingPeopleVaccinated
FROM Portfolio..CovidDeaths dea
JOIN Portfolio..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
--WHERE dea.continent is not null
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/population)*100 
FROM #PercentPopulationVaccinated



--Creating view to store dat for later visulaizations in Tableau

Create View PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by 
dea.location, dea.date) as RollingPeopleVaccinated
FROM Portfolio..CovidDeaths dea
JOIN Portfolio..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null


/*

Queries used for Tableau Project

*/



-- 1. Total cases, total deaths and global death rate

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Portfolio..CovidDeaths
where continent is not null 
order by 1,2


-- 2. 

-- NB: European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Portfolio..CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Portfolio..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc


-- 4.


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Portfolio..CovidDeaths
Group by Location, Population, date
order by PercentPopulationInfected desc
