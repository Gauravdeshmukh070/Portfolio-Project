
select *
from NashvilleHousing


select SaleDate
from SQLPortfolioProject..NashvilleHousing

update NashvilleHousing
set SaleDate = Convert(Date,SaleDate)

alter table NashvilleHousing
add SaleDateConverted Date;

update NashvilleHousing
set SaleDateConverted = Convert(Date,SaleDate)

select SaleDateConverted
from NashvilleHousing


select *
from SQLPortfolioProject..NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyAddress,b.PropertyAddress)
from SQLPortfolioProject..NashvilleHousing a
join SQLPortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

update a
set PropertyAddress = isnull(a.propertyAddress,b.PropertyAddress)
from SQLPortfolioProject..NashvilleHousing a
join SQLPortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


select 
SUBSTRING(propertyaddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address

from SQLPortfolioProject..NashvilleHousing


select 
SUBSTRING(propertyaddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
, SUBSTRING(propertyaddress, CHARINDEX(',', PropertyAddress) + 1,len(PropertyAddress) ) as Address
from SQLPortfolioProject..NashvilleHousing


alter table NashvilleHousing
add propertysplitAddress nvarchar(255);

update NashvilleHousing
set propertysplitAddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', PropertyAddress) -1 )


alter table NashvilleHousing
add propertysplitCity nvarchar(255);

update NashvilleHousing
set propertysplitcity = SUBSTRING(propertyaddress, CHARINDEX(',', PropertyAddress) + 1,len(PropertyAddress) )

select propertysplitAddress, propertysplitCity
from NashvilleHousing

select 
PARSENAME(replace(OwnerAddress,',','.'), 3)
,PARSENAME(replace(OwnerAddress,',','.'), 2)
,PARSENAME(replace(OwnerAddress,',','.'), 1)
from NashvilleHousing


alter table NashvilleHousing
add OwnersplitAddress nvarchar(255);

update NashvilleHousing
set OwnersplitAddress = PARSENAME(replace(OwnerAddress,',','.'), 3)


alter table NashvilleHousing
add OwnersplitCity nvarchar(255);

update NashvilleHousing
set OwnersplitCity = PARSENAME(replace(OwnerAddress,',','.'), 2)


alter table NashvilleHousing
add OwnersplitState nvarchar(255);

update NashvilleHousing
set OwnersplitState = PARSENAME(replace(OwnerAddress,',','.'), 1)

select distinct(SoldAsVacant), count(soldasvacant)
from NashvilleHousing
group by SoldAsVacant
order by 2


select SoldAsVacant
,case when SoldAsVacant = '1' then 'Yes'
	  when SoldAsVacant = '0' then 'No'
	  else SoldAsVacant
	  End
from NashvilleHousing

alter table [dbo].[NashvilleHousing]
alter column soldasvacant nvarchar(255)
go


update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = '1' then 'Yes'
						when SoldAsVacant = '0' then 'No'
						else SoldAsVacant
						End


select *
from NashvilleHousing

--Remove Duplicates

with RowNumCTE as(
select *,
	ROW_NUMBER() over(
	partition by ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 order by uniqueID
				 ) as Row_Num
From NashvilleHousing
)
Delete
from RowNumCTE
where Row_Num > 1

select *
from NashvilleHousing

alter table  NashvilleHousing
drop column PropertyAddress, OwnerAddress, TaxDistrict, saleDate

alter table  NashvilleHousing
drop column saleDate












