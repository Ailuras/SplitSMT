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

(declare-sort var1564 0)
(declare-sort var3423 0)
(declare-sort var3597 0)
(declare-sort var629 0)
(declare-sort var3764 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3423 String) String)
(declare-fun var629_isEmpty/-813097145 (String) Bool)
(declare-fun getActivateExtension/634900197 (var1564 var3423 (Array Int String) String) var3764)
(declare-const null-var1564 var1564)
(declare-const null-var3423 var3423)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var188 var1564) ; Statement: r3 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var188 null-var1564)))
(declare-const var3286 var3423) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3286 null-var3423)))
(declare-const var1634 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1634 null-String)))
(declare-const var1232 String) ; Statement: r5 := @parameter2: java.lang.String 
(assert (not (= var1232 null-String)))
(assert true)
(define-const var1950 String (getParameter/-1307325648 var3286 var1634)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2362 Bool (var629_isEmpty/-813097145 var1950)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (not (= (ite var2362 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1285 (Array Int String) null-__Array__Int__String__) ; Statement: $r7 = null 
 ; Statement: goto [?= $r6 = virtualinvoke r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[],java.lang.String)>(r0, $r7, r5)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2226 var3764 (getActivateExtension/634900197 var188 var3286 var1285 var1232)) ; Statement: $r6 = virtualinvoke r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[],java.lang.String)>(r0, $r7, r5) 
 ; Statement: return $r6 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var629_isEmpty/-813097145=([java.lang.String], boolean), getActivateExtension/634900197=([org.apache.dubbo.common.extension.ExtensionLoader, org.apache.dubbo.common.URL, java.lang.String[], java.lang.String], java.util.List)}
; {var1564=org.apache.dubbo.common.extension.ExtensionLoader, var188=r3, var3423=org.apache.dubbo.common.URL, var3286=r0, var1634=r1, var3597=null_type, var1232=r5, var1950=r2, var629=org.apache.dubbo.common.utils.StringUtils, var2362=$z0, var1285=$r7, var3764=java.util.List, var2226=$r6}
; {org.apache.dubbo.common.extension.ExtensionLoader=var1564, r3=var188, org.apache.dubbo.common.URL=var3423, r0=var3286, r1=var1634, null_type=var3597, r5=var1232, r2=var1950, org.apache.dubbo.common.utils.StringUtils=var629, $z0=var2362, $r7=var1285, java.util.List=var3764, $r6=var2226}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: java.lang.String;	r5 := @parameter2: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r7 = null;	goto [?= $r6 = virtualinvoke r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[],java.lang.String)>(r0, $r7, r5)];	$r6 = virtualinvoke r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[],java.lang.String)>(r0, $r7, r5);	return $r6
;block_num 3