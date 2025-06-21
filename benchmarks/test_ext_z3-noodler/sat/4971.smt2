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

(declare-sort var2227 0)
(declare-sort var2188 0)
(declare-sort var848 0)
(declare-sort var1776 0)
(declare-sort var1204 0)
(declare-sort var1329 0)
(declare-sort var2594 0)
(declare-sort var127 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2227 String) String)
(declare-fun var1776_isEmpty/-813097145 (String) Bool)
(declare-fun split/1265909012 (var1204 String) (Array Int String))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2594_asList/1779083644 ((Array Int var127)) var848)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var127__ ((Array Int String)) (Array Int var127))
(declare-const null-var2227 var2227)
(declare-const null-String String)
(declare-const null-var848 var848)
(declare-const var1329-COMMA_SPLIT_PATTERN var1204)
(declare-const var868 var2227) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var868 null-var2227)))
(declare-const var377 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var377 null-String)))
(declare-const var2526 var848) ; Statement: r6 := @parameter1: java.util.List 
(assert (not (= var2526 null-var848)))
(assert true)
(define-const var3385 String (getParameter/-1307325648 var868 var377)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2844 Bool (var1776_isEmpty/-813097145 var3385)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (= (ite var2844 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1924 var1204 var1329-COMMA_SPLIT_PATTERN) ; Statement: $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert true)
(define-const var1650 (Array Int String) (split/1265909012 var1924 (cast-from-String-to-String var3385))) ; Statement: r4 = virtualinvoke $r3.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r2) 
(define-const var1859 var848 (var2594_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var127__ var1650))) ; Statement: $r5 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r4) 
 ; Statement: return $r5 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1776_isEmpty/-813097145=([java.lang.String], boolean), split/1265909012=([java.util.regex.Pattern, java.lang.CharSequence], java.lang.String[]), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2594_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var127__=([java.lang.String[]], java.lang.Object[])}
; {var2227=org.apache.dubbo.common.URL, var868=r0, var377=r1, var2188=null_type, var848=java.util.List, var2526=r6, var3385=r2, var1776=org.apache.dubbo.common.utils.StringUtils, var2844=$z0, var1204=java.util.regex.Pattern, var1329=org.apache.dubbo.common.constants.CommonConstants, var1924=$r3, var1650=r4, var2594=java.util.Arrays, var127=java.lang.Object, var1859=$r5}
; {org.apache.dubbo.common.URL=var2227, r0=var868, r1=var377, null_type=var2188, java.util.List=var848, r6=var2526, r2=var3385, org.apache.dubbo.common.utils.StringUtils=var1776, $z0=var2844, java.util.regex.Pattern=var1204, org.apache.dubbo.common.constants.CommonConstants=var1329, $r3=var1924, r4=var1650, java.util.Arrays=var2594, java.lang.Object=var127, $r5=var1859}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r6 := @parameter1: java.util.List;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	r4 = virtualinvoke $r3.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r2);	$r5 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r4);	return $r5
;block_num 2