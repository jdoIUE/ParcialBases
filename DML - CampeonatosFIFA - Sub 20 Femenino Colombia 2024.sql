--Abrir la base de datos
USE CampeonatosFIFA

--Declaracion de variables
DECLARE @nuevoIdPais int,
	@IdColombia int,
	@nuevoIdCampeonato int,
	@nuevoIdCiudad int,
	@nuevoIdEstadio int,
	@IdMedellin int, @IdCali int, @IdBogota int,
	@IdEstadio1 int, @IdEstadio2 int, @IdEstadio3 int, @IdEstadio4 int,
	@nuevoIdGrupo int,
	@IdPais1Grupo int, @IdPais2Grupo int, @IdPais3Grupo int, @IdPais4Grupo int,
	@totalPaises int,
	@nuevoIdEncuentro int;

--Obtener el Id de un nuevo PAIS
SELECT @nuevoIdPais=MAX(Id)+1
	FROM Pais;

--***** Agregar el Campeonato ****

SELECT @IdColombia=Id 
	FROM Pais 
	WHERE Pais='Colombia';
IF @IdColombia IS NULL --Verifica si 'Colombia' no est� en la base de datos
BEGIN
	SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonum�rico
	INSERT INTO Pais
		(Id, Pais, EntIdad) VALUES(@nuevoIdPais, 'Colombia', 'Federaci�n Colombiana de Futbol');
	SET IDENTITY_INSERT Pais OFF
	SET @IdColombia = @nuevoIdPais;
	SET @nuevoIdPais = @nuevoIdPais + 1;
END

--Validar si ya est� el campeonato
SELECT @nuevoIdCampeonato=Id 
    FROM Campeonato
    WHERE Campeonato='FIFA U-20 Women''s World Cup Colombia 2024';
IF @nuevoIdCampeonato IS NULL --Verifica si el campeonato no est� en la base de datos
BEGIN
	INSERT INTO Campeonato
		(Campeonato, IdPais, A�o)
		VALUES('FIFA U-20 Women''s World Cup Colombia 2024', @IdColombia, 2024);
	SELECT @nuevoIdCampeonato=Id 
		FROM Campeonato
		WHERE Campeonato='FIFA U-20 Women''s World Cup Colombia 2024';
END

--***** Agregar las ciudades y Estadios de los Encuentros *****

--Obtener el Id de una nueva CIUDAD
SELECT @nuevoIdCiudad=MAX(Id)+1
	FROM Ciudad;

--Obtener el Id de un nuevo Estadio
SELECT @nuevoIdEstadio=MAX(Id)+1
        FROM Estadio;

SELECT @IdEstadio1=Id
	FROM Estadio 
	WHERE Estadio='Estadio Atanasio Girardot';
IF @IdEstadio1 IS NULL --Verifica si 'Estadio Atanasio Girardot' no est� en la base de datos
BEGIN
	SELECT @IdMedellin=Id FROM Ciudad WHERE Ciudad='Medell�n';
	IF @IdMedellin IS NULL  --Verifica si 'Medell�n' no est� en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonum�rico
			INSERT INTO Ciudad
				(Id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Medell�n', @IdColombia);
			SET IDENTITY_INSERT Ciudad OFF
			SET @IdMedellin = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;
	--Agregar Estadio
	SET IDENTITY_INSERT Estadio ON --Obliga a reemplazar el Id autonum�rico
	INSERT INTO Estadio
		(Id, Estadio, CapacIdad, IdCiudad) VALUES(@nuevoIdEstadio, 'Estadio Atanasio Girardot', 0, @IdMedellin);
	SET IDENTITY_INSERT Estadio OFF
	SET @IdEstadio1 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END

SELECT @IdEstadio2=Id
	FROM Estadio 
	WHERE Estadio='Estadio Ol�mpico Pascual Guerrero';
IF @IdEstadio2 IS NULL --Verifica si 'Estadio Ol�mpico Pascual Guerrero' no est� en la base de datos
BEGIN
	SELECT @IdCali=Id FROM Ciudad WHERE Ciudad='Cali';
    IF @IdCali IS NULL 
BEGIN
        SET IDENTITY_INSERT Ciudad ON;
        INSERT INTO Ciudad 
			(Id, Ciudad, IdPais) VALUES (@nuevoIdCiudad, 'Cali', @IdColombia);
        SET IDENTITY_INSERT Ciudad OFF;
        SET @IdCali = @nuevoIdCiudad;
        SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
    END;
	--Agregar Estadio
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, CapacIdad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Ol�mpico Pascual Guerrero', 0, @IdCali);
    SET IDENTITY_INSERT Estadio OFF;
    SET @IdEstadio2 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @IdEstadio3=Id
	FROM Estadio 
	WHERE Estadio='Estadio Nemesio Camacho El Camp�n';
IF @IdEstadio3 IS NULL --Verifica si 'Estadio Nemesio Camacho El Camp�n' no est� en la base de datos
BEGIN
	SELECT @IdBogota=Id FROM Ciudad WHERE Ciudad='Bogot�';
    IF @IdBogota IS NULL 
BEGIN
        SET IDENTITY_INSERT Ciudad ON;
        INSERT INTO Ciudad 
			(Id, Ciudad, IdPais) VALUES (@nuevoIdCiudad, 'Bogot�', @IdColombia);
        SET IDENTITY_INSERT Ciudad OFF;
        SET @IdBogota = @nuevoIdCiudad;
        --SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
    END;
	--Agregar Estadio
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, CapacIdad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Nemesio Camacho El Camp�n', 0, @IdBogota);
    SET IDENTITY_INSERT Estadio OFF;
    SET @IdEstadio3 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @IdEstadio4=Id
	FROM Estadio 
	WHERE Estadio='Estadio Metropolitano de Techo';
IF @IdEstadio4 IS NULL --Verifica si 'Estadio Metropolitano de Techo' no est� en la base de datos
BEGIN
    IF @IdBogota IS NULL 
BEGIN
		SELECT @IdBogota=Id  FROM ciudad WHERE ciudad='Bogot�';
    END;
	--Agregar Estadio
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, CapacIdad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Metropolitano de Techo', 0, @IdBogota);
    SET IDENTITY_INSERT Estadio OFF;
    SET @IdEstadio4 = @nuevoIdEstadio;
	--SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

--***** Validar si ya estan los Grupos del Campeonato *****

SELECT @nuevoIdGrupo=Id 
    FROM Grupo
    WHERE IdCampeonato = @nuevoIdCampeonato
        AND Grupo='A';
IF @nuevoIdGrupo IS NULL --Los grupos no estan
BEGIN
	SELECT @nuevoIdGrupo=MAX(Id)+1 FROM Grupo;
	SET IDENTITY_INSERT Grupo ON;
	INSERT INTO Grupo
		(Id, Grupo, IdCampeonato)
		VALUES
		(@nuevoIdGrupo, 'A', @nuevoIdCampeonato),
		(@nuevoIdGrupo+1, 'B', @nuevoIdCampeonato),
		(@nuevoIdGrupo+2, 'C', @nuevoIdCampeonato),
		(@nuevoIdGrupo+3, 'D', @nuevoIdCampeonato),
		(@nuevoIdGrupo+4, 'E', @nuevoIdCampeonato),
		(@nuevoIdGrupo+5, 'F', @nuevoIdCampeonato);
	SET IDENTITY_INSERT Grupo OFF;
END

--***** Validar si ya est�n los Paises del Grupo A *****

SET @IdPais1Grupo = @IdColombia; --'Colombia' es el Pais1 del Grupo A

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonum�rico

SELECT @IdPais2Grupo=Id  FROM Pais WHERE pais='Australia';
IF @IdPais2Grupo IS NULL --verifica si 'Australia' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, EntIdad) VALUES(@nuevoIdPais, 'Australia', '');
    SET @IdPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais3Grupo=Id  FROM Pais WHERE pais='Camer�n';
IF @IdPais3Grupo IS NULL --verifica si 'Camer�n' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, EntIdad) VALUES(@nuevoIdPais, 'Camer�n', '');
    SET @IdPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais4Grupo=Id  FROM Pais WHERE pais='M�xico';
IF @IdPais4Grupo IS NULL --verifica si 'Camer�n' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, EntIdad) VALUES(@nuevoIdPais, 'M�xico', '');
    SET @IdPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;
SET IDENTITY_INSERT Pais OFF

SELECT @totalPaises=COUNT(*)
    FROM GrupoPais
    WHERE IdGrupo=@nuevoIdGrupo;

IF @totalPaises=0
BEGIN
	INSERT INTO GrupoPais
		(IdGrupo, IdPais)
		VALUES
		(@nuevoIdGrupo, @IdPais1Grupo),
		(@nuevoIdGrupo, @IdPais2Grupo),
		(@nuevoIdGrupo, @IdPais3Grupo),
		(@nuevoIdGrupo, @IdPais4Grupo)
END

--Obtener el Id de un nuevo Encuentro
SELECT @nuevoIdEncuentro=MAX(Id)+1
	FROM Encuentro;

--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo A *****

SET IDENTITY_INSERT Encuentro ON --Obliga a reemplazar el Id autonum�rico

-- Camer�n vs M�xico
IF NOT EXISTS(SELECT * FROM Encuentro
            WHERE IdPais1 = @IdPais3Grupo AND IdPais2 = @IdPais4Grupo
                AND IdFase =1 AND IdCampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais3Grupo, 2, @IdPais4Grupo, 2, '2024-08-31', @IdEstadio3, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Colombia vs Australia
IF NOT EXISTS(SELECT * FROM Encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais2Grupo
                AND IdFase =1 AND IdCampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 2, @IdPais2Grupo, 0, '2024-08-31', @IdEstadio3, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- M�xico vs Australia
IF NOT EXISTS(SELECT * FROM Encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais2Grupo
                AND IdFase =1 AND IdCampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 2, @IdPais2Grupo, 0, '2024-09-03', @IdEstadio3, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Colombia vs Camer�n
IF NOT EXISTS(SELECT * FROM Encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais3Grupo
                AND IdFase =1 AND IdCampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 1, @IdPais3Grupo, 0, '2024-09-03', @IdEstadio3, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- M�xico vs Colombia
IF NOT EXISTS(SELECT * FROM Encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais1Grupo
                AND IdFase =1 AND IdCampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 0, @IdPais1Grupo, 1, '2024-09-06', @IdEstadio1, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Australia vs Camer�n
IF NOT EXISTS(SELECT * FROM Encuentro
            WHERE IdPais1 = @IdPais2Grupo AND IdPais2 = @IdPais3Grupo
                AND IdFase =1 AND IdCampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais2Grupo, 0, @IdPais3Grupo, 2, '2024-09-03', @IdEstadio3, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;
SET IDENTITY_INSERT Encuentro OFF

--***** Validar si ya est�n los Paises del Grupo B *****
SET @idPais1Grupo=NULL;
SET @idPais2Grupo=NULL;
SET @idPais3Grupo=NULL;
SET @idPais4Grupo=NULL;

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonum�rico

SELECT @IdPais1Grupo=Id  FROM pais WHERE pais='Francia';
IF @IdPais1Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Francia', '');
    SET @IdPais1Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;
    
SELECT @IdPais2Grupo=Id  FROM pais WHERE pais='Canad�';
IF @IdPais2Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Canad�', '');
    SET @IdPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais3Grupo=Id  FROM pais WHERE pais='Brasil';
IF @IdPais3Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Brasil', '');
    SET @IdPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais4Grupo=Id  FROM pais WHERE pais='Fiyi';
IF @IdPais4Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Fiyi', '');
    SET @IdPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;
SET IDENTITY_INSERT Pais OFF

SELECT @totalPaises=COUNT(*)
    FROM GrupoPais
    WHERE IdGrupo=@nuevoIdGrupo+1;
IF @totalPaises=0 BEGIN
    INSERT INTO GrupoPais
        (IdGrupo, IdPais)
        VALUES
        (@nuevoIdGrupo+1, @IdPais1Grupo),
        (@nuevoIdGrupo+1, @IdPais2Grupo),
        (@nuevoIdGrupo+1, @IdPais3Grupo),
        (@nuevoIdGrupo+1, @IdPais4Grupo);
END;

--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo B *****

SET IDENTITY_INSERT Encuentro ON --Obliga a reemplazar el Id autonum�rico
-- Francia vs Canad�
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 3, @IdPais2Grupo, 3, '2024-08-31', @IdEstadio1, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Brasil vs Fiyi
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais3Grupo AND IdPais2 = @IdPais4Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais3Grupo, 9, @IdPais4Grupo, 0, '2024-08-31', @IdEstadio1, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Francia vs Brasil
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 0, @IdPais3Grupo, 3, '2024-09-03', @IdEstadio1, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Fiyi vs Canad�
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 0, @IdPais2Grupo, 9, '2024-09-03', @IdEstadio1, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Fiyi vs Francia
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais1Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 0, @IdPais1Grupo, 11, '2024-09-06', @IdEstadio1, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Canad� vs Brasil
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais2Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais2Grupo, 0, @IdPais3Grupo, 2, '2024-09-06', @IdEstadio3, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

SET IDENTITY_INSERT Encuentro OFF

--***** Validar si ya est�n los Paises del Grupo C *****
SET @idPais1Grupo=NULL;
SET @idPais2Grupo=NULL;
SET @idPais3Grupo=NULL;
SET @idPais4Grupo=NULL;

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonum�rico

SELECT @IdPais1Grupo=Id  FROM pais WHERE pais='Espa�a';
IF @IdPais1Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Espa�a', '');
    SET @IdPais1Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;
    
SELECT @IdPais2Grupo=Id  FROM pais WHERE pais='Estados Unidos';
IF @IdPais2Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Estados Unidos', '');
    SET @IdPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais3Grupo=Id  FROM pais WHERE pais='Paraguay';
IF @IdPais3Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Paraguay', '');
    SET @IdPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais4Grupo=Id  FROM pais WHERE pais='Marruecos';
IF @IdPais4Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Marruecos', '');
    SET @IdPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SET IDENTITY_INSERT Pais OFF

SELECT @totalPaises=COUNT(*)
    FROM GrupoPais
    WHERE IdGrupo=@nuevoIdGrupo+2;
IF @totalPaises=0 
BEGIN
    INSERT INTO GrupoPais
        (IdGrupo, IdPais)
        VALUES
        (@nuevoIdGrupo+2, @IdPais1Grupo),
        (@nuevoIdGrupo+2, @IdPais2Grupo),
        (@nuevoIdGrupo+2, @IdPais3Grupo),
        (@nuevoIdGrupo+2, @IdPais4Grupo);
END;

--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo C *****

SET IDENTITY_INSERT Encuentro ON --Obliga a reemplazar el Id autonum�rico

-- Espa�a vs Estados Unidos
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 1, @IdPais2Grupo, 0, '2024-09-01', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Paraguay vs Marruecos
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais3Grupo AND IdPais2 = @IdPais4Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais3Grupo, 2, @IdPais4Grupo, 0, '2024-09-01', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Espa�a vs Paraguay
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 2, @IdPais3Grupo, 0, '2024-09-04', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Marruecos vs Estados Unidos
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 0, @IdPais2Grupo, 2, '2024-09-04', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Marruecos vs Espa�a
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais1Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 0, @IdPais1Grupo, 2, '2024-09-07', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

    -- Estados Unidos vs Paraguay
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais2Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais2Grupo, 7, @IdPais3Grupo, 0, '2024-09-07', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

SET IDENTITY_INSERT Encuentro OFF

--***** Validar si ya est�n los Paises del Grupo D *****
SET @idPais1Grupo=NULL;
SET @idPais2Grupo=NULL;
SET @idPais3Grupo=NULL;
SET @idPais4Grupo=NULL;

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonum�rico

SELECT @IdPais1Grupo=Id  FROM pais WHERE pais='Alemania';
IF @IdPais1Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Alemania', '');
    SET @IdPais1Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;
    
SELECT @IdPais2Grupo=Id  FROM pais WHERE pais='Venezuela';
IF @IdPais2Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Venezuela', '');
    SET @IdPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais3Grupo=Id  FROM pais WHERE pais='Nigeria';
IF @IdPais3Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Nigeria', '');
    SET @IdPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais4Grupo=Id  FROM pais WHERE pais='Corea del Sur';
IF @IdPais4Grupo IS NULL BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Corea del Sur', '');
    SET @IdPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SET IDENTITY_INSERT Pais OFF

SELECT @totalPaises=COUNT(*) 
	FROM GrupoPais 
	WHERE IdGrupo=@nuevoIdGrupo+3;
IF @totalPaises=0 BEGIN
    INSERT INTO GrupoPais
    (IdGrupo, IdPais)
    VALUES
    (@nuevoIdGrupo+3, @IdPais1Grupo),
    (@nuevoIdGrupo+3, @IdPais2Grupo),
    (@nuevoIdGrupo+3, @IdPais3Grupo),
    (@nuevoIdGrupo+3, @IdPais4Grupo);
END;       

--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo D *****

SET IDENTITY_INSERT Encuentro ON --Obliga a reemplazar el Id autonum�rico

-- Alemania vs Venezuela
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 5, @IdPais2Grupo, 2, '2024-09-01', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Nigeria vs Corea del Sur
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais3Grupo AND IdPais2 = @IdPais4Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais3Grupo, 1, @IdPais4Grupo, 0, '2024-09-01', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Alemania vs Nigeria
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 3, @IdPais3Grupo, 1, '2024-09-04', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Corea del Sur vs Venezuela
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 0, @IdPais2Grupo, 0, '2024-09-04', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Corea del Sur vs Alemania
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais1Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 1, @IdPais1Grupo, 0, '2024-09-07', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Venezuela vs Nigeria
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais2Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais2Grupo, 0, @IdPais3Grupo, 4, '2024-09-07', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

SET IDENTITY_INSERT Encuentro OFF

--***** Validar si ya est�n los Paises del Grupo E *****
SET @idPais1Grupo=NULL;
SET @idPais2Grupo=NULL;
SET @idPais3Grupo=NULL;
SET @idPais4Grupo=NULL;

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonum�rico

SELECT @IdPais1Grupo=Id  FROM pais WHERE pais='Jap�n';
IF @IdPais1Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Jap�n', '');
    SET @IdPais1Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;
    
SELECT @IdPais2Grupo=Id  FROM pais WHERE pais='Nueva Zelanda';
IF @IdPais2Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Nueva Zelanda', '');
    SET @IdPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais3Grupo=Id  FROM pais WHERE pais='Ghana';
IF @IdPais3Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Ghana', '');
    SET @IdPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais4Grupo=Id  FROM pais WHERE pais='Austria';
IF @IdPais4Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Austria', '');
    SET @IdPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SET IDENTITY_INSERT Pais OFF

SELECT @totalPaises=COUNT(*)
	FROM GrupoPais 
	WHERE IdGrupo=@nuevoIdGrupo+4;
IF @totalPaises=0 BEGIN
    INSERT INTO GrupoPais
    (IdGrupo, IdPais)
    VALUES
    (@nuevoIdGrupo+4, @IdPais1Grupo),
    (@nuevoIdGrupo+4, @IdPais2Grupo),
    (@nuevoIdGrupo+4, @IdPais3Grupo),
    (@nuevoIdGrupo+4, @IdPais4Grupo);
END; 

--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo E *****

SET IDENTITY_INSERT Encuentro ON --Obliga a reemplazar el Id autonum�rico

-- Jap�n vs Nueva Zelanda
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 7, @IdPais2Grupo, 0, '2024-09-02', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Ghana vs Austria
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais3Grupo AND IdPais2 = @IdPais4Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais3Grupo, 1, @IdPais4Grupo, 2, '2024-09-02', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Jap�n vs Ghana
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 4, @IdPais3Grupo, 1, '2024-09-05', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Austria vs Nueva Zelanda
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 3, @IdPais2Grupo, 1, '2024-09-05', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Austria vs Jap�n
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais1Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 0, @IdPais1Grupo, 2, '2024-09-08', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Nueva Zelanda vs Ghana
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais2Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais2Grupo, 1, @IdPais3Grupo, 3, '2024-09-08', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

SET IDENTITY_INSERT Encuentro OFF

--***** Validar si ya est�n los Paises del Grupo F *****
SET @idPais1Grupo=NULL;
SET @idPais2Grupo=NULL;
SET @idPais3Grupo=NULL;
SET @idPais4Grupo=NULL;

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonum�rico

SELECT @IdPais1Grupo=Id  FROM pais WHERE pais='Corea del Norte';
IF @IdPais1Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Corea del Norte', '');
    SET @IdPais1Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;
    
SELECT @IdPais2Grupo=Id  FROM pais WHERE pais='Argentina';
IF @IdPais2Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Argentina', '');
    SET @IdPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais3Grupo=Id  FROM pais WHERE pais='Costa Rica';
IF @IdPais3Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Costa Rica', '');
    SET @IdPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @IdPais4Grupo=Id  FROM pais WHERE pais='Holanda';
IF @IdPais4Grupo IS NULL 
BEGIN
    INSERT INTO pais
        (Id, pais, entidad) VALUES(@nuevoIdPais, 'Holanda', '');
    SET @IdPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SET IDENTITY_INSERT Pais OFF

SELECT @totalPaises=COUNT(*)
	FROM GrupoPais 
	WHERE IdGrupo=@nuevoIdGrupo+5;
IF @totalPaises=0 BEGIN
    INSERT INTO GrupoPais
    (IdGrupo, IdPais)
    VALUES
    (@nuevoIdGrupo+5, @IdPais1Grupo),
    (@nuevoIdGrupo+5, @IdPais2Grupo),
    (@nuevoIdGrupo+5, @IdPais3Grupo),
    (@nuevoIdGrupo+5, @IdPais4Grupo);
END;


--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo F *****

SET IDENTITY_INSERT Encuentro ON --Obliga a reemplazar el Id autonum�rico

-- Corea del Norte vs Argentina
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 6, @IdPais2Grupo, 2, '2024-09-02', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Costa Rica vs Pa�ses Bajos
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais3Grupo AND IdPais2 = @IdPais4Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais3Grupo, 0, @IdPais4Grupo, 2, '2024-09-02', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Corea del Norte vs Costa Rica
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais1Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais1Grupo, 9, @IdPais3Grupo, 0, '2024-09-05', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Pa�ses Bajos vs Argentina
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais2Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 3, @IdPais2Grupo, 3, '2024-09-05', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Pa�ses Bajos vs Corea del Norte
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais4Grupo AND IdPais2 = @IdPais1Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais4Grupo, 0, @IdPais1Grupo, 2, '2024-09-08', @IdEstadio2, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

-- Argentina vs Costa Rica
IF NOT EXISTS(SELECT * FROM encuentro
            WHERE IdPais1 = @IdPais2Grupo AND IdPais2 = @IdPais3Grupo
                AND idfase =1 AND idcampeonato = @nuevoIdCampeonato ) 
BEGIN
    INSERT INTO Encuentro
        (Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
        VALUES(@nuevoIdEncuentro, @IdPais2Grupo, 1, @IdPais3Grupo, 0, '2024-09-08', @IdEstadio4, 1, @nuevoIdCampeonato);
    SET @nuevoIdEncuentro = @nuevoIdEncuentro + 1;
END;

SET IDENTITY_INSERT Encuentro OFF