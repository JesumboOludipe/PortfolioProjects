
SELECT *
FROM Portfolio..CovidDeaths
Where continent is not null
ORDER BY 3,4


--SELECT *
--FROM Portfolio..CovidVaccinations
--ORDER BY 3,4

--Select data to be used
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM Portfolio..CovidDeaths
ORDER BY 1,2

--Looking at Total Deaths vs Total Cases
--Shows the likelihood of dieing if you contract COVID
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate
FROM Portfolio..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

--Death rate in Nigeria
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate
FROM Portfolio..CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2

--Looking at Total Cases vs Population
--Shows percentage of population that got COVID
SELECT location, date, Population, total_cases, (total_cases/Population)*100 as cases_percentage
FROM Portfolio..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2


--Looking at Countries with Highest infection rate compared to Population
SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/Population))*100 as percent_population_infected
FROM Portfolio..CovidDeaths
GROUP BY location, population
ORDER BY percent_population_infected desc

--Showing countries with Highest Death rate with respect to Population
SELECT location, MAX(CAST(total_deaths as int)) as total_death_count
FROM Portfolio..CovidDeaths
Where continent is not null
GROUP BY location
ORDER BY total_death_count desc

--LET'S BREAK THINGS DOWN BY CONTINENT
--Showing continents with the highest death count per population
SELECT location, MAX(CAST(total_deaths as int)) as total_death_count
FROM Portfolio..CovidDeaths
Where continent is null
GROUP BY location
ORDER BY total_death_count desc


--Global numbers

--Global daily total deaths and death rates 
SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_rate
FROM Portfolio..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

--Total deaths and Global death rate
SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_rate
FROM Portfolio..CovidDeaths
WHERE continent is not null
ORDER BY 1,2


--VACCINATIONS
SELECT *
FROM Portfolio..CovidDeaths dea
JOIN Portfolio..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date

-- Showing Total population and Total Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM Portfolio..CovidDeaths dea
JOIN Portfolio..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

--Rolling count of People Vaccinated

--USE CTE
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


--TEMP TABLE

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

--Creating view to store dat for later visulaizations

Create View PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by 
dea.location, dea.date) as RollingPeopleVaccinated
FROM Portfolio..CovidDeaths dea
JOIN Portfolio..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3