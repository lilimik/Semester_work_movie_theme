package ru.itis.services;

import ru.itis.models.Restriction;
import ru.itis.repositories.RestrictionsRepository;

import java.util.List;

public class RestrictionServiceImpl implements RestrictionService {

    private final RestrictionsRepository restrictionsRepository;

    public RestrictionServiceImpl(RestrictionsRepository restrictionsRepository) {
        this.restrictionsRepository = restrictionsRepository;
    }

    @Override
    public List<Restriction> findAll() {
        return restrictionsRepository.findAll();
    }

}
