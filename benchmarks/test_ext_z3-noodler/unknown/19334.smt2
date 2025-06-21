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

(declare-sort var2253 0)
(declare-sort var2997 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2253_getKey/-33423493 (var2253) var2997)
(declare-fun cast-from-var2997-to-String (var2997) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2253_getValue/381491177 (var2253) var2997)
(declare-fun append/-1031950772 (String var2997) String)
(declare-const null-String String)
(declare-const null-var2253 var2253)
(declare-const var1815 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1815 null-String)))
(declare-const var657 var2253) ; Statement: r1 := @parameter1: java.util.Map$Entry 
(assert (not (= var657 null-var2253)))
(define-const var1855 var2997 (var2253_getKey/-33423493 var657)) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getKey()>() 
(define-const var1519 String (cast-from-var2997-to-String var1855)) ; Statement: $r3 = (java.lang.String) $r2 
(assert true)
(define-const var2566 String (append/672562846 var1815 var1519)) ; Statement: $r4 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1815!1 String)
(assert (= var1815!1 (str.++ var1815 var1519)))
(assert true)
(define-const var3773 String (append/672562846 var2566 "=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=") 
(declare-const var2566!1 String)
(assert (= var2566!1 (str.++ var2566 "=")))
(define-const var156 var2997 (var2253_getValue/381491177 var657)) ; Statement: $r5 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>() 
(assert true)
(define-const var1737 String (append/-1031950772 var3773 var156)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var3773!1 String)
(assert (str.prefixof var3773 var3773!1))
(assert true)
;(assert (append/672562846 var1737 ";\n")) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";\n") 
(declare-const var1737!1 String)
(assert (= var1737!1 (str.++ var1737 ";\n")))
 ; Statement: return 
(check-sat)
; {var2253_getKey/-33423493=([java.util.Map$Entry], java.lang.Object), cast-from-var2997-to-String=([java.lang.Object], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2253_getValue/381491177=([java.util.Map$Entry], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder)}
; {var1815=r0, var2253=java.util.Map$Entry, var657=r1, var2997=java.lang.Object, var1855=$r2, var1519=$r3, var2566=$r4, var3773=$r6, var156=$r5, var1737=$r7}
; {r0=var1815, java.util.Map$Entry=var2253, r1=var657, java.lang.Object=var2997, $r2=var1855, $r3=var1519, $r4=var2566, $r6=var3773, $r5=var156, $r7=var1737}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: java.util.Map$Entry;	$r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getKey()>();	$r3 = (java.lang.String) $r2;	$r4 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=");	$r5 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";\n");	return
;block_num 1