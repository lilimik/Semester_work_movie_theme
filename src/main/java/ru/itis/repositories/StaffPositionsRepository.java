package ru.itis.repositories;

import ru.itis.models.StaffPosition;

public interface StaffPositionsRepository extends CrudRepository<StaffPosition> {
    Short findIdByName(String description);
}
