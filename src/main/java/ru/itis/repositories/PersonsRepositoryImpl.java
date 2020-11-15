package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.Person;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class PersonsRepositoryImpl implements PersonsRepository {

    private final JdbcTemplate jdbcTemplate;

    public PersonsRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_FIND_PERSON_BY_ID = "select * from persons where id = ?";
    private static final String SQL_FIND_ALL = "select * from persons";
    private static final String SQL_DELETE_PERSON_BY_ID = "delete from persons where id = ?";
    private static final String SQL_INSERT_PERSON = "insert into persons(first_name, last_name, born, country_id, sex_id) values (?, ?, ?, ?, ?)";

    RowMapper<Person> personRowMapper = (row, rowNumber) -> Person.builder()
            .id(row.getLong("id"))
            .firstName(row.getString("first_name"))
            .lastName(row.getString("last_name"))
            .born(row.getShort("born"))
            .countryId(row.getInt("country_id"))
            .sex_id(row.getInt("sex_id"))
            .build();

    @Override
    public void save(Person entity) {
        jdbcTemplate.update(SQL_INSERT_PERSON, entity.getFirstName(), entity.getLastName(), entity.getBorn(), entity.getCountryId(), entity.getSex_id());
    }

    @Override
    public void update(Person entity) {

    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_PERSON_BY_ID, id);
    }

    @Override
    public Optional<Person> findById(Long id) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_PERSON_BY_ID, personRowMapper, id));
    }

    @Override
    public List<Person> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, personRowMapper);
    }

}
