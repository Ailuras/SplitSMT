(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var30 0)
(declare-sort var2012 0)
(declare-sort var1259 0)
(declare-sort var1094 0)
(declare-sort var1544 0)
(declare-sort var3604 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var2012_of/184955601 ((Array Int var1259)) var2012)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1259__ ((Array Int String)) (Array Int var1259))
(declare-fun var1544_bootstrap$/2009511014 () var1094)
(declare-fun var2012_mapToDouble/-1409710570 (var2012 var1094) var3604)
(declare-fun var3604_toArray/286542371 (var3604) (Array Int Real))
(declare-const null-String String)
(declare-const var1362 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1362 null-String)))
(assert true)
(define-const var1029 Int (indexOf/-1037706067 var1362 40)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(40) 
(define-const var3698 Int (+ var1029 1)) ; Statement: $i3 = $i0 + 1 
(assert true)
(define-const var1951 Int (length/-134980193 var1362)) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2415 Int (- var1951 1)) ; Statement: $i2 = $i1 - 1 
(assert (not (and true (and (>= var3698 0) (>= (str.len var1362) var2415) (>= var2415 var3698)))))
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var2012_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1259__=([java.lang.String[]], java.lang.Object[]), var1544_bootstrap$/2009511014=([], java.util.function.ToDoubleFunction), var2012_mapToDouble/-1409710570=([java.util.stream.Stream, java.util.function.ToDoubleFunction], java.util.stream.DoubleStream), var3604_toArray/286542371=([java.util.stream.DoubleStream], double[])}
; {var1362=r0, var30=null_type, var1029=$i0, var3698=$i3, var1951=$i1, var2415=$i2, var84=$r1, var23=r2, var2012=java.util.stream.Stream, var1259=java.lang.Object, var531=$r4, var1094=java.util.function.ToDoubleFunction, var1544=org.jline.utils.Colors$parseDouble__415, var1803=$r3, var3604=java.util.stream.DoubleStream, var1986=$r5, var2156=$r6}
; {r0=var1362, null_type=var30, $i0=var1029, $i3=var3698, $i1=var1951, $i2=var2415, $r1=var84, r2=var23, java.util.stream.Stream=var2012, java.lang.Object=var1259, $r4=var531, java.util.function.ToDoubleFunction=var1094, org.jline.utils.Colors$parseDouble__415=var1544, $r3=var1803, java.util.stream.DoubleStream=var3604, $r5=var1986, $r6=var2156}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(40);	$i3 = $i0 + 1;	$i1 = virtualinvoke r0.<java.lang.String: int length()>();	$i2 = $i1 - 1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($i3, $i2);	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>(r2);	$r3 = staticinvoke <org.jline.utils.Colors$parseDouble__415: java.util.function.ToDoubleFunction bootstrap$()>();	$r5 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.DoubleStream mapToDouble(java.util.function.ToDoubleFunction)>($r3);	$r6 = interfaceinvoke $r5.<java.util.stream.DoubleStream: double[] toArray()>();	return $r6
;block_num 1