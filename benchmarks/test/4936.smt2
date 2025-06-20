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

(declare-sort var1545 0)
(declare-sort var1503 0)
(declare-sort var113 0)
(declare-sort var1770 0)
(declare-sort var263 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1545 String) String)
(declare-fun var113_isEmpty/-813097145 (String) Bool)
(declare-fun split/1265909012 (var1770 String) (Array Int String))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var1545 var1545)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var263-COMMA_SPLIT_PATTERN var1770)
(declare-const var3218 var1545) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3218 null-var1545)))
(declare-const var808 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var808 null-String)))
(declare-const var2884 (Array Int String)) ; Statement: r4 := @parameter1: java.lang.String[] 
(assert (not (= var2884 null-__Array__Int__String__)))
(assert true)
(define-const var1871 String (getParameter/-1307325648 var3218 var808)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1043 Bool (var113_isEmpty/-813097145 var1871)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (= (ite var1043 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2918 var1770 var263-COMMA_SPLIT_PATTERN) ; Statement: $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert true)
(define-const var632 (Array Int String) (split/1265909012 var2918 (cast-from-String-to-String var1871))) ; Statement: $r5 = virtualinvoke $r3.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r2) 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var113_isEmpty/-813097145=([java.lang.String], boolean), split/1265909012=([java.util.regex.Pattern, java.lang.CharSequence], java.lang.String[]), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1545=org.apache.dubbo.common.URL, var3218=r0, var808=r1, var1503=null_type, var2884=r4, var1871=r2, var113=org.apache.dubbo.common.utils.StringUtils, var1043=$z0, var1770=java.util.regex.Pattern, var263=org.apache.dubbo.common.constants.CommonConstants, var2918=$r3, var632=$r5}
; {org.apache.dubbo.common.URL=var1545, r0=var3218, r1=var808, null_type=var1503, r4=var2884, r2=var1871, org.apache.dubbo.common.utils.StringUtils=var113, $z0=var1043, java.util.regex.Pattern=var1770, org.apache.dubbo.common.constants.CommonConstants=var263, $r3=var2918, $r5=var632}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.String[];	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r5 = virtualinvoke $r3.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r2);	return $r5
;block_num 3