unit uFicheros;
interface
USES uConjuntos,uElem,uProc,crt;

	PROCEDURE Cartones;
	PROCEDURE cargar(VAR fich:TFileElem;ruta:string;VAR conjunto:TConjunto);
	PROCEDURE guardar(VAR save:TFileElem);

implementation

	PROCEDURE Cartones;
	CONST
		MAX=15; (* numeros de cada carton*)
	VAR
		conjunto:TConjunto;
		ruta:string[100];
		archivo:text;
		numero,j,k:integer;
		num:TElemento;
	BEGIN
		numero:=0;
		write('Numero de cartones a generar: ');
		readln(numero);
		write('Introduce una ruta donde guardar: ');
		readln(ruta);
		writeln;
		assign(archivo,ruta);
		rewrite(archivo);
		FOR j:=1 TO numero DO
		BEGIN
			write(archivo,'Cart�n ',j,':  ');
			crearconjuntovacio(conjunto);
			generador(50,conjunto);
			FOR k:=1 TO MAX DO
				BEGIN
				num:=Elegir(conjunto);
				write(archivo,num ,' ');
				eliminar(num,conjunto);
			END;
			writeln(archivo);
			writeln(archivo);
		END;
		close(archivo);
		writeln('Se ha guardado con exito el archivo ',ruta,' ');
	END;


PROCEDURE cargar(VAR fich:TFileElem;ruta:string;VAR conjunto:TConjunto);
VAR
	elem,a,b:TElemento;
	l:integer;
	fin:boolean;
BEGIN
	a:=0;
	b:=0;
	l:=0;
	fin:=FALSE;
	assign(fich, ruta);
	{$I-}   {Desactica el control de errores}
	reset(fich);
	{$I+}   {Actica el control de errores}
	IF IORESULT= 0 THEN   {IORESULT almacena el n�mero de fallos en el tiempo que estaba desactivado el cotrol}
		tablero;
		crearconjuntovacio(conjunto);
		Generador(50,conjunto);
		tablero;
		IF (filesize(fich)<50) AND (filesize(fich)>0) THEN
		BEGIN
			WHILE NOT EOF(fich)	DO
			BEGIN
				seek(fich, l);
				read(fich,elem);
				colores(elem,a,b);
				eliminar(elem,conjunto);
				l:=l+1;
			END;
		close(fich);
		instrucciones;
		readln;
		sorteo(conjunto,a,b,TRUE,fin);
		END
		ELSE
		BEGIN
			close(fich);
			crearconjuntovacio(conjunto);
			Generador(50,conjunto);
			window(1,16,80,25);
			gotoXY(7,4);
			write('Pulsa [ENTER] para comenzar...');
			readln;
			tablero;
			a:=0;
			b:=0;
			sorteo(conjunto,a,b,FALSE,fin);
		END;
END;

PROCEDURE guardar(VAR save:TFileElem);
VAR
	rut:string;
BEGIN
	window(1,1,80,25);
	textbackground(0);
	clrscr;
	logo;
	Window(26,7,54,7);
	TextColor(11);
	TextBackground(1);
	write('#######    GUARDAR   #######');
	Window(12,10,80,25);
	TextBackGround(0);
	gotoXY(43,16);
	TextColor(8);
	write(chr(184),'2012 TurboBingo Unlimited');
	Window(12,10,80,25);
	TextBackGround(0);
	TextColor(7);
	assign(save,'save.tmp');
	Write('Introduce un nombre para el fichero: ');
	readln(rut);
	rut:=rut +'.sav';
	rename(save,rut);
	gotoxy(1,12);
	write('Pulsa ');
	TextColor(15);
	write('[ENTER]');
	TextColor(7);
	write(' para continuar ... ');
	readln;
END;

end.
