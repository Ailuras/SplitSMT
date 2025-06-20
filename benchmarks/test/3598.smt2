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

(declare-sort var227 0)
(declare-sort var748 0)
(declare-sort var691 0)
(declare-sort var1338 0)
(declare-sort var1382 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun val2Index/-1887099830 (var227) var691)
(declare-fun toLowerCase/1946809429 (String var1338) String)
(declare-fun var691_get/1088891777 (var691 var1382) var1382)
(declare-fun cast-from-String-to-var1382 (String) var1382)
(declare-fun cast-from-var1382-to-Int (var1382) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-const null-var227 var227)
(declare-const null-String String)
(declare-const var1338-ROOT var1338)
(declare-const null-Int Int)
(declare-const var1734 var227) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.param.FixedParamValue 
(assert (not (= var1734 null-var227)))
(declare-const var424 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var424 null-String)))
(define-const var3553 var691 (val2Index/-1887099830 var1734)) ; Statement: $r3 = r0.<org.apache.dubbo.common.url.component.param.FixedParamValue: java.util.Map val2Index> 
(define-const var174 var1338 var1338-ROOT) ; Statement: $r2 = <java.util.Locale: java.util.Locale ROOT> 
(assert true)
(define-const var1402 String (toLowerCase/1946809429 var424 var174)) ; Statement: $r4 = virtualinvoke r1.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r2) 
(define-const var2271 var1382 (var691_get/1088891777 var3553 (cast-from-String-to-var1382 var1402))) ; Statement: $r5 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>($r4) 
(define-const var759 Int (cast-from-var1382-to-Int var2271)) ; Statement: r6 = (java.lang.Integer) $r5 
 ; Statement: if r6 != null goto $i0 = virtualinvoke r6.<java.lang.Integer: int intValue()>() 
(assert (not (= var759 null-Int))) ; Cond: r6 != null 
(assert true)
(define-const var1726 Int (intValue/-1815674922 var759)) ; Statement: $i0 = virtualinvoke r6.<java.lang.Integer: int intValue()>() 
 ; Statement: return $i0 
(check-sat)
; {val2Index/-1887099830=([org.apache.dubbo.common.url.component.param.FixedParamValue], java.util.Map), toLowerCase/1946809429=([java.lang.String, java.util.Locale], java.lang.String), var691_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1382=([java.lang.String], java.lang.Object), cast-from-var1382-to-Int=([java.lang.Object], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int)}
; {var227=org.apache.dubbo.common.url.component.param.FixedParamValue, var1734=r0, var424=r1, var748=null_type, var691=java.util.Map, var3553=$r3, var1338=java.util.Locale, var174=$r2, var1402=$r4, var1382=java.lang.Object, var2271=$r5, var759=r6, var1726=$i0}
; {org.apache.dubbo.common.url.component.param.FixedParamValue=var227, r0=var1734, r1=var424, null_type=var748, java.util.Map=var691, $r3=var3553, java.util.Locale=var1338, $r2=var174, $r4=var1402, java.lang.Object=var1382, $r5=var2271, r6=var759, $i0=var1726}
;seq <java.lang.String: java.lang.String toLowerCase(java.util.Locale)>
;cnt {"<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.param.FixedParamValue;	r1 := @parameter0: java.lang.String;	$r3 = r0.<org.apache.dubbo.common.url.component.param.FixedParamValue: java.util.Map val2Index>;	$r2 = <java.util.Locale: java.util.Locale ROOT>;	$r4 = virtualinvoke r1.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r2);	$r5 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>($r4);	r6 = (java.lang.Integer) $r5;	if r6 != null goto $i0 = virtualinvoke r6.<java.lang.Integer: int intValue()>();	$i0 = virtualinvoke r6.<java.lang.Integer: int intValue()>();	return $i0
;block_num 2