--Кількість запитів без Виконавця всього
SELECT  Count(tick1.id)
FROM    glpi_tickets tick1
WHERE   NOT EXISTS
        (
        SELECT  null 
        FROM    glpi_tickets_users tickus2
        WHERE   tickus2.tickets_id = tick1.id and tickus2.type = 2 
        )

Select Count(tick1.id) from glpi_tickets as tick1
Left join  glpi_tickets_users as tick2 
on tick1.id=tick2.tickets_id and tick2.type = 2
where tick2.users_id is null



--Кількість запитів без Виконавця, що зареєстровано сьогодні (нові)

SELECT  Count(tick1.id)
FROM    glpi_tickets tick1
WHERE tick1.status = 1 and DATE(tick1.date_creation) = DATE(NOW()) and  NOT EXISTS 
        (
        SELECT  null 
        FROM    glpi_tickets_users tickus2
        WHERE   tickus2.tickets_id = tick1.id and tickus2.type = 2 
        )

--Зареєстровано нових запитів за поточний день

Select Count(id) from glpi_tickets
where Date(date_creation) = DATE(NOW()) 

--Вирішено запитів за поточний день

Select Count(id) from glpi_tickets
where Date(date_creation)  = DATE(NOW()) and status = 5


--Вирішено запитів за поточний день виконавцями

SELECT users.id, concat_ws(" ", users.realname, users.firstname), Count(tikus.tickets_id)
From glpi_users users
Inner join glpi_tickets_users tikus on users.id = tikus.users_id
Inner join glpi_tickets tiks on tiks.id = tikus.tickets_id
where DATE(tiks.solvedate) = DATE(NOW()) and tikus.type = 2 
group by users.id


--Вирішено запитів за поточний день групами

SELECT groups.id, groups.name, Count(grtk.tickets_id)
From glpi_groups groups
Inner join glpi_groups_tickets grtk on groups.id = grtk.groups_id
Inner join glpi_tickets tiks on tiks.id = grtk.tickets_id
where DATE(tiks.solvedate) = DATE(NOW()) and grtk.type = 2  and groups.name LIKE "%ІТ%"
group by groups.id

