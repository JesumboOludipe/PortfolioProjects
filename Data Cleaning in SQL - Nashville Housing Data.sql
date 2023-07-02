/****** 

Cleaning Data in SQL Queries

******/

-- Commands Used - SELECT, FROM, UPDATE, SET, WHERE, ALTER TABLE, ALTER COLUMN, GROUP  BY, ORDER BY, 
		 -- ADD, INNER JOIN, DISTINCT, CASE WHEN, WITH, DROP COLUMN, NESTED QUERIES

SELECT *
FROM Portfolio..NashvilleHousing


--Standartdize Date Format

SELECT SaleDateConverted, CONVERT(Date, Saledate)
FROM Portfolio..NashvilleHousing

UPDATE Portfolio..NashvilleHousing
SET Saledate = CONVERT(Date, Saledate)


--Add New Column
ALTER TABLE Portfolio..NashvilleHousing
ADD SaleDateConverted Date;

UPDATE Portfolio..NashvilleHousing
SET SaleDateConverted = CONVERT(Date, Saledate)



--Populate Property Address data where null

SELECT *
FROM Portfolio..NashvilleHousing
--WHERE PropertyAddress is null
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Portfolio..NashvilleHousing a
JOIN Portfolio..NashvilleHousing b
	ON a.ParcelID = a.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Portfolio..NashvilleHousing a
JOIN Portfolio..NashvilleHousing b
	ON a.ParcelID = a.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null



--Breaking out Address into Individual Columns (Address, City, State)

-- Using SUBSTRING
SELECT PropertyAddress
FROM Portfolio..NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
FROM Portfolio..NashvilleHousing

ALTER TABLE Portfolio..NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE Portfolio..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE Portfolio..NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE Portfolio..NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


-- Using PARSENAME
SELECT OwnerAddress
FROM Portfolio..NashvilleHousing

SELECT
PARSENAME(REPLACE(OwnerAddress, ',','.') , 3),
PARSENAME(REPLACE(OwnerAddress, ',','.') , 2),
PARSENAME(REPLACE(OwnerAddress, ',','.') , 1)
FROM Portfolio..NashvilleHousing

ALTER TABLE Portfolio..NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE Portfolio..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.') , 3)

ALTER TABLE Portfolio..NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

UPDATE Portfolio..NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.') , 2)

ALTER TABLE Portfolio..NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

UPDATE Portfolio..NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.') , 1)

SELECT *
FROM Portfolio..NashvilleHousing



--Change Y and N to Yes and No in "Sold as vacant" field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM Portfolio..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2 DESC

SELECT SoldAsVacant,
CASE	WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END
FROM Portfolio..NashvilleHousing

UPDATE Portfolio..NashvilleHousing
SET  SoldAsVacant = CASE	WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END



--Remove Duplicates
--Using CTE - Common Table Expression

SELECT *
FROM Portfolio..NashvilleHousing

WITH RowNumCTE AS(
SELECT *, 
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

FROM Portfolio..NashvilleHousing
--ORDER BY row_num
)
SELECT *
FROM RowNumCTE
WHERE row_num>1


--Delete Unused Columns

SELECT *
FROM Portfolio..NashvilleHousing


ALTER TABLE Portfolio..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE Portfolio..NashvilleHousing
DROP COLUMN SaleDate

