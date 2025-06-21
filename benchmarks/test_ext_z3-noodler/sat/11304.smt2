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

(declare-sort var2915 0)
(declare-sort var1966 0)
(declare-sort var3111 0)
(declare-sort var1442 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCategory/-1855000632 (var2915) String)
(declare-fun var1966_isEmpty/-813097145 (String) Bool)
(declare-fun split/1265909012 (var3111 String) (Array Int String))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2915 var2915)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1442-COMMA_SPLIT_PATTERN var3111)
(declare-const var2042 var2915) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2042 null-var2915)))
(declare-const var2027 (Array Int String)) ; Statement: r3 := @parameter0: java.lang.String[] 
(assert (not (= var2027 null-__Array__Int__String__)))
(assert true)
(define-const var1600 String (getCategory/-1855000632 var2042)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>() 
(define-const var3693 Bool (var1966_isEmpty/-813097145 var1600)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (= (ite var3693 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3751 var3111 var1442-COMMA_SPLIT_PATTERN) ; Statement: $r2 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert true)
(define-const var1804 (Array Int String) (split/1265909012 var3751 (cast-from-String-to-String var1600))) ; Statement: $r4 = virtualinvoke $r2.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r1) 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {getCategory/-1855000632=([org.apache.dubbo.common.URL], java.lang.String), var1966_isEmpty/-813097145=([java.lang.String], boolean), split/1265909012=([java.util.regex.Pattern, java.lang.CharSequence], java.lang.String[]), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2915=org.apache.dubbo.common.URL, var2042=r0, var2027=r3, var1600=r1, var1966=org.apache.dubbo.common.utils.StringUtils, var3693=$z0, var3111=java.util.regex.Pattern, var1442=org.apache.dubbo.common.constants.CommonConstants, var3751=$r2, var1804=$r4}
; {org.apache.dubbo.common.URL=var2915, r0=var2042, r3=var2027, r1=var1600, org.apache.dubbo.common.utils.StringUtils=var1966, $z0=var3693, java.util.regex.Pattern=var3111, org.apache.dubbo.common.constants.CommonConstants=var1442, $r2=var3751, $r4=var1804}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r3 := @parameter0: java.lang.String[];	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r2 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r4 = virtualinvoke $r2.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r1);	return $r4
;block_num 3