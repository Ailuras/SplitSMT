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

(declare-sort var2747 0)
(declare-sort var2358 0)
(declare-sort var698 0)
(declare-sort var2353 0)
(declare-sort var2051 0)
(declare-sort var190 0)
(declare-sort var3277 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2358 String) String)
(declare-fun var2353_isEmpty/-813097145 (String) Bool)
(declare-fun split/1265909012 (var2051 String) (Array Int String))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getActivateExtension/634900197 (var2747 var2358 (Array Int String) String) var3277)
(declare-const null-var2747 var2747)
(declare-const null-var2358 var2358)
(declare-const null-String String)
(declare-const var190-COMMA_SPLIT_PATTERN var2051)
(declare-const var1034 var2747) ; Statement: r3 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var1034 null-var2747)))
(declare-const var2920 var2358) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2920 null-var2358)))
(declare-const var3287 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3287 null-String)))
(declare-const var3521 String) ; Statement: r5 := @parameter2: java.lang.String 
(assert (not (= var3521 null-String)))
(assert true)
(define-const var1410 String (getParameter/-1307325648 var2920 var3287)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var867 Bool (var2353_isEmpty/-813097145 var1410)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (= (ite var867 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2789 var2051 var190-COMMA_SPLIT_PATTERN) ; Statement: $r4 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert true)
(define-const var2297 (Array Int String) (split/1265909012 var2789 (cast-from-String-to-String var1410))) ; Statement: $r7 = virtualinvoke $r4.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r2) 
(assert true) ; Non Conditional
(assert true)
(define-const var3749 var3277 (getActivateExtension/634900197 var1034 var2920 var2297 var3521)) ; Statement: $r6 = virtualinvoke r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[],java.lang.String)>(r0, $r7, r5) 
 ; Statement: return $r6 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2353_isEmpty/-813097145=([java.lang.String], boolean), split/1265909012=([java.util.regex.Pattern, java.lang.CharSequence], java.lang.String[]), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getActivateExtension/634900197=([org.apache.dubbo.common.extension.ExtensionLoader, org.apache.dubbo.common.URL, java.lang.String[], java.lang.String], java.util.List)}
; {var2747=org.apache.dubbo.common.extension.ExtensionLoader, var1034=r3, var2358=org.apache.dubbo.common.URL, var2920=r0, var3287=r1, var698=null_type, var3521=r5, var1410=r2, var2353=org.apache.dubbo.common.utils.StringUtils, var867=$z0, var2051=java.util.regex.Pattern, var190=org.apache.dubbo.common.constants.CommonConstants, var2789=$r4, var2297=$r7, var3277=java.util.List, var3749=$r6}
; {org.apache.dubbo.common.extension.ExtensionLoader=var2747, r3=var1034, org.apache.dubbo.common.URL=var2358, r0=var2920, r1=var3287, null_type=var698, r5=var3521, r2=var1410, org.apache.dubbo.common.utils.StringUtils=var2353, $z0=var867, java.util.regex.Pattern=var2051, org.apache.dubbo.common.constants.CommonConstants=var190, $r4=var2789, $r7=var2297, java.util.List=var3277, $r6=var3749}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: java.lang.String;	r5 := @parameter2: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r4 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r7 = virtualinvoke $r4.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r2);	$r6 = virtualinvoke r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[],java.lang.String)>(r0, $r7, r5);	return $r6
;block_num 3