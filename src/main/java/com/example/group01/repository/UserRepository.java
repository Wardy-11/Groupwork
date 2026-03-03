package com.example.group01.repository;

import com.example.group01.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String username);
    boolean existsByUsername(String username);

    @Query("SELECT f FROM User u JOIN u.friends f WHERE u.id = :userId AND LOWER(f) LIKE LOWER(CONCAT('%', :username, '%'))")
    List<String> findFriendsByUsername(@Param("userId") Long userId, @Param("username") String username);

    List<User> findAllByUsernameContainingIgnoreCase(String keyword);
}
