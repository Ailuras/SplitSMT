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

(declare-sort var1027 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1027_getKey/1511768516 (var1027) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1027_getValue/-747672590 (var1027) String)
(declare-const null-String String)
(declare-const null-var1027 var1027)
(declare-const var1785 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1785 null-String)))
(declare-const var3072 var1027) ; Statement: r1 := @parameter1: io.micrometer.core.instrument.Tag 
(assert (not (= var3072 null-var1027)))
(define-const var15 String (var1027_getKey/1511768516 var3072)) ; Statement: $r2 = interfaceinvoke r1.<io.micrometer.core.instrument.Tag: java.lang.String getKey()>() 
(assert true)
(define-const var2872 String (append/672562846 var1785 var15)) ; Statement: $r3 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1785!1 String)
(assert (= var1785!1 (str.++ var1785 var15)))
(assert true)
(define-const var2327 String (append/672562846 var2872 "=")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=") 
(declare-const var2872!1 String)
(assert (= var2872!1 (str.++ var2872 "=")))
(define-const var3478 String (var1027_getValue/-747672590 var3072)) ; Statement: $r4 = interfaceinvoke r1.<io.micrometer.core.instrument.Tag: java.lang.String getValue()>() 
(assert true)
(define-const var705 String (append/672562846 var2327 var3478)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2327!1 String)
(assert (= var2327!1 (str.++ var2327 var3478)))
(assert true)
;(assert (append/672562846 var705 ",")) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var705!1 String)
(assert (= var705!1 (str.++ var705 ",")))
 ; Statement: return 
(check-sat)
; {var1027_getKey/1511768516=([io.micrometer.core.instrument.Tag], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1027_getValue/-747672590=([io.micrometer.core.instrument.Tag], java.lang.String)}
; {var1785=r0, var1027=io.micrometer.core.instrument.Tag, var3072=r1, var15=$r2, var2872=$r3, var2327=$r5, var3478=$r4, var705=$r6}
; {r0=var1785, io.micrometer.core.instrument.Tag=var1027, r1=var3072, $r2=var15, $r3=var2872, $r5=var2327, $r4=var3478, $r6=var705}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: io.micrometer.core.instrument.Tag;	$r2 = interfaceinvoke r1.<io.micrometer.core.instrument.Tag: java.lang.String getKey()>();	$r3 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=");	$r4 = interfaceinvoke r1.<io.micrometer.core.instrument.Tag: java.lang.String getValue()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	return
;block_num 1