(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3459 0)
(declare-sort var876 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3459_getKey/-33423493 (var3459) var876)
(declare-fun cast-from-var876-to-String (var876) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3459_getValue/381491177 (var3459) var876)
(declare-fun append/-1031950772 (String var876) String)
(declare-const null-String String)
(declare-const null-var3459 var3459)
(declare-const var2835 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2835 null-String)))
(declare-const var1426 var3459) ; Statement: r1 := @parameter1: java.util.Map$Entry 
(assert (not (= var1426 null-var3459)))
(define-const var1406 var876 (var3459_getKey/-33423493 var1426)) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getKey()>() 
(define-const var473 String (cast-from-var876-to-String var1406)) ; Statement: $r3 = (java.lang.String) $r2 
(assert true)
(define-const var2711 String (append/672562846 var2835 var473)) ; Statement: $r4 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2835!1 String)
(assert (= var2835!1 (str.++ var2835 var473)))
(assert true)
(define-const var2114 String (append/672562846 var2711 "=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=") 
(declare-const var2711!1 String)
(assert (= var2711!1 (str.++ var2711 "=")))
(define-const var3668 var876 (var3459_getValue/381491177 var1426)) ; Statement: $r5 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>() 
(assert true)
(define-const var2100 String (append/-1031950772 var2114 var3668)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2114!1 String)
(assert (str.prefixof var2114 var2114!1))
(assert true)
;(assert (append/672562846 var2100 ";\n")) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";\n") 
(declare-const var2100!1 String)
(assert (= var2100!1 (str.++ var2100 ";\n")))
 ; Statement: return 
(check-sat)
; {var3459_getKey/-33423493=([java.util.Map$Entry], java.lang.Object), cast-from-var876-to-String=([java.lang.Object], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3459_getValue/381491177=([java.util.Map$Entry], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder)}
; {var2835=r0, var3459=java.util.Map$Entry, var1426=r1, var876=java.lang.Object, var1406=$r2, var473=$r3, var2711=$r4, var2114=$r6, var3668=$r5, var2100=$r7}
; {r0=var2835, java.util.Map$Entry=var3459, r1=var1426, java.lang.Object=var876, $r2=var1406, $r3=var473, $r4=var2711, $r6=var2114, $r5=var3668, $r7=var2100}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: java.util.Map$Entry;	$r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getKey()>();	$r3 = (java.lang.String) $r2;	$r4 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=");	$r5 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";\n");	return
;block_num 1