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

(declare-sort var3372 0)
(declare-sort var1715 0)
(declare-sort var2625 0)
(declare-sort var634 0)
(declare-sort var3742 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3372_get/1088891777 (var3372 var2625) var2625)
(declare-fun cast-from-String-to-var2625 (String) var2625)
(declare-fun cast-from-var2625-to-var634 (var2625) var634)
(declare-fun append/-1031950772 (String var2625) String)
(declare-fun var3742_lineSeparator/-342590142 () String)
(declare-const null-String String)
(declare-const null-var3372 var3372)
(declare-const null-var2625 var2625)
(declare-const null-var634 var634)
(declare-const var637 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var637 null-String)))
(declare-const var2386 var3372) ; Statement: r3 := @parameter1: java.util.Map 
(assert (not (= var2386 null-var3372)))
(declare-const var1184 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var1184 null-String)))
(declare-const var3933 var2625) ; Statement: r6 := @parameter3: java.lang.Object 
(assert (not (= var3933 null-var2625)))
(assert true)
(define-const var3142 String (append/672562846 var637 var1184)) ; Statement: $r2 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var637!1 String)
(assert (= var637!1 (str.++ var637 var1184)))
(assert true)
;(assert (append/672562846 var3142 "{")) ; Statement: virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("{") 
(declare-const var3142!1 String)
(assert (= var3142!1 (str.++ var3142 "{")))
(define-const var2722 var2625 (var3372_get/1088891777 var2386 (cast-from-String-to-var2625 var1184))) ; Statement: $r4 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1101 var634 (cast-from-var2625-to-var634 var2722)) ; Statement: r5 = (java.util.List) $r4 
 ; Statement: if r5 == null goto $r8 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("} ") 
(assert (= var1101 null-var634)) ; Cond: r5 == null 
(assert true)
(define-const var2194 String (append/672562846 var637!1 "} ")) ; Statement: $r8 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("} ") 
(declare-const var637!2 String)
(assert (= var637!2 (str.++ var637!1 "} ")))
(assert true)
(define-const var1633 String (append/-1031950772 var2194 var3933)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r6) 
(declare-const var2194!1 String)
(assert (str.prefixof var2194 var2194!1))
(define-const var3598 String var3742_lineSeparator/-342590142) ; Statement: $r10 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>() 
(assert true)
;(assert (append/672562846 var1633 var3598)) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var1633!1 String)
(assert (= var1633!1 (str.++ var1633 var3598)))
 ; Statement: return 
(check-sat)
; {append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3372_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2625=([java.lang.String], java.lang.Object), cast-from-var2625-to-var634=([java.lang.Object], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), var3742_lineSeparator/-342590142=([], java.lang.String)}
; {var637=r0, var3372=java.util.Map, var2386=r3, var1184=r1, var1715=null_type, var2625=java.lang.Object, var3933=r6, var3142=$r2, var2722=$r4, var634=java.util.List, var1101=r5, var2194=$r8, var1633=$r9, var3742=java.lang.System, var3598=$r10}
; {r0=var637, java.util.Map=var3372, r3=var2386, r1=var1184, null_type=var1715, java.lang.Object=var2625, r6=var3933, $r2=var3142, $r4=var2722, java.util.List=var634, r5=var1101, $r8=var2194, $r9=var1633, java.lang.System=var3742, $r10=var3598}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r3 := @parameter1: java.util.Map;	r1 := @parameter2: java.lang.String;	r6 := @parameter3: java.lang.Object;	$r2 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("{");	$r4 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r5 = (java.util.List) $r4;	if r5 == null goto $r8 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("} ");	$r8 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("} ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r6);	$r10 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>();	virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	return
;block_num 2