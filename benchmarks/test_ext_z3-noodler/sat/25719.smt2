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

(declare-sort var698 0)
(declare-sort var187 0)
(declare-sort var716 0)
(declare-sort var1105 0)
(declare-sort var1975 0)
(declare-sort var3509 0)
(declare-sort var781 0)
(declare-sort var2427 0)
(declare-sort var622 0)
(declare-sort var1987 0)
(declare-sort var2160 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var716-init () var716)
(declare-fun <init>/-325640736 (var716) void)
(declare-fun getParameter/-1307325648 (var187 String) String)
(declare-fun var1105-init () var1105)
(declare-fun var3509_bootstrap$/-1978803770 (var698) var1975)
(declare-fun <init>/-2092627944 (var1105 var1975) void)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun var781_tokenize/-290051344 (String (Array Int Int)) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var622-init () var622)
(declare-fun arr-var2160-init () (Array Int var2160))
(declare-fun cast-from-String-to-var2160 (String) var2160)
(declare-fun cast-from-var187-to-var2160 (var187) var2160)
(declare-fun <init>/268816097 (var622 var2427 var1987 (Array Int var2160)) void)
(declare-const null-var698 var698)
(declare-const null-var187 var187)
(declare-const null-var2427 var2427)
(declare-const var1987-EXTENSION_INIT_FAILED var1987)
(declare-const null-__Array__Int__var2160__ (Array Int var2160))
(declare-const var1502 var698) ; Statement: r4 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter 
(assert (not (= var1502 null-var698)))
(declare-const var1649 var187) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1649 null-var187)))
(define-const var831 var716 var716-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var831)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var831!1 var716)
(assert true)
(define-const var480 String (getParameter/-1307325648 var1649 "extension")) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("extension") 
(define-const var2443 var1105 var1105-init) ; Statement: $r3 = new org.apache.dubbo.common.beans.support.InstantiationStrategy 
(define-const var1731 var1975 (var3509_bootstrap$/-1978803770 var1502)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter$lambda_loadFilters_3__1427: org.apache.dubbo.rpc.model.ScopeModelAccessor bootstrap$(org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter)>(r4) 
(assert true)
;(assert (<init>/-2092627944 var2443 var1731)) ; Statement: specialinvoke $r3.<org.apache.dubbo.common.beans.support.InstantiationStrategy: void <init>(org.apache.dubbo.rpc.model.ScopeModelAccessor)>($r5) 

(declare-const var2443!1 var1105)
(declare-const var1731!1 var1975)
(define-const var1680 (Array Int Int) arr-Int-init) ; Statement: $r6 = newarray (char)[0] 
(define-const var2882 (Array Int String) (var781_tokenize/-290051344 var480 var1680)) ; Statement: r25 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>(r2, $r6) 
(define-const var3456 Int (getLength-Arr-String-1 var2882)) ; Statement: i0 = lengthof r25 
(define-const var3595 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r7 = r4.<org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (not (>= var3595 var3456))) ; Negate: Cond: i1 >= i0  
(define-const var1469 String (select var2882 var3595)) ; Statement: r17 = r25[i1] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var689 var2427) ; Statement: $r21 := @caughtexception 
(assert (not (= var689 null-var2427)))
(define-const var3706 var622 var622-init) ; Statement: $r22 = new org.apache.dubbo.rpc.protocol.tri.rest.RestInitializeException 
(define-const var995 var1987 var1987-EXTENSION_INIT_FAILED) ; Statement: $r24 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages EXTENSION_INIT_FAILED> 
(define-const var1115 (Array Int var2160) arr-var2160-init) ; Statement: $r23 = newarray (java.lang.Object)[2] 
(declare-const var1115!1 (Array Int var2160))
(assert (not (= var1115!1 null-__Array__Int__var2160__)))
(assert (= (select var1115!1 0) (cast-from-String-to-var2160 var1469))) ; Statement: $r23[0] = r17 
(declare-const var1115!2 (Array Int var2160))
(assert (not (= var1115!2 null-__Array__Int__var2160__)))
(assert (= (select var1115!2 1) (cast-from-var187-to-var2160 var1649))) ; Statement: $r23[1] = r1 
(assert true)
;(assert (<init>/268816097 var3706 var689 var995 var1115!2)) ; Statement: specialinvoke $r22.<org.apache.dubbo.rpc.protocol.tri.rest.RestInitializeException: void <init>(java.lang.Throwable,org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r21, $r24, $r23) 

(declare-const var3706!1 var622)
(declare-const var689!1 var2427)
(declare-const var995!1 var1987)
(declare-const var1115!3 (Array Int var2160))
 ; Statement: throw $r22 
(check-sat)
; {var716-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1105-init=([], org.apache.dubbo.common.beans.support.InstantiationStrategy), var3509_bootstrap$/-1978803770=([org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter], org.apache.dubbo.rpc.model.ScopeModelAccessor), <init>/-2092627944=([org.apache.dubbo.common.beans.support.InstantiationStrategy, org.apache.dubbo.rpc.model.ScopeModelAccessor], void), arr-Int-init=([], char[]), var781_tokenize/-290051344=([java.lang.String, char[]], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int), var622-init=([], org.apache.dubbo.rpc.protocol.tri.rest.RestInitializeException), arr-var2160-init=([], java.lang.Object[]), cast-from-String-to-var2160=([java.lang.String], java.lang.Object), cast-from-var187-to-var2160=([org.apache.dubbo.common.URL], java.lang.Object), <init>/268816097=([org.apache.dubbo.rpc.protocol.tri.rest.RestInitializeException, java.lang.Throwable, org.apache.dubbo.rpc.protocol.tri.rest.Messages, java.lang.Object[]], void)}
; {var698=org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter, var1502=r4, var187=org.apache.dubbo.common.URL, var1649=r1, var716=java.util.ArrayList, var831=$r0, var480=r2, var1105=org.apache.dubbo.common.beans.support.InstantiationStrategy, var2443=$r3, var1975=org.apache.dubbo.rpc.model.ScopeModelAccessor, var3509=org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter$lambda_loadFilters_3__1427, var1731=$r5, var1680=$r6, var781=org.apache.dubbo.common.utils.StringUtils, var2882=r25, var3456=i0, var3595=i1, var1469=r17, var2427=java.lang.Throwable, var689=$r21, var622=org.apache.dubbo.rpc.protocol.tri.rest.RestInitializeException, var3706=$r22, var1987=org.apache.dubbo.rpc.protocol.tri.rest.Messages, var995=$r24, var2160=java.lang.Object, var1115=$r23}
; {org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter=var698, r4=var1502, org.apache.dubbo.common.URL=var187, r1=var1649, java.util.ArrayList=var716, $r0=var831, r2=var480, org.apache.dubbo.common.beans.support.InstantiationStrategy=var1105, $r3=var2443, org.apache.dubbo.rpc.model.ScopeModelAccessor=var1975, org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter$lambda_loadFilters_3__1427=var3509, $r5=var1731, $r6=var1680, org.apache.dubbo.common.utils.StringUtils=var781, r25=var2882, i0=var3456, i1=var3595, r17=var1469, java.lang.Throwable=var2427, $r21=var689, org.apache.dubbo.rpc.protocol.tri.rest.RestInitializeException=var622, $r22=var3706, org.apache.dubbo.rpc.protocol.tri.rest.Messages=var1987, $r24=var995, java.lang.Object=var2160, $r23=var1115}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("extension");	$r3 = new org.apache.dubbo.common.beans.support.InstantiationStrategy;	$r5 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter$lambda_loadFilters_3__1427: org.apache.dubbo.rpc.model.ScopeModelAccessor bootstrap$(org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter)>(r4);	specialinvoke $r3.<org.apache.dubbo.common.beans.support.InstantiationStrategy: void <init>(org.apache.dubbo.rpc.model.ScopeModelAccessor)>($r5);	$r6 = newarray (char)[0];	r25 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>(r2, $r6);	i0 = lengthof r25;	i1 = 0;	if i1 >= i0 goto $r7 = r4.<org.apache.dubbo.rpc.protocol.tri.rest.filter.RestExtensionExecutionFilter: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	r17 = r25[i1];	$r21 := @caughtexception;	$r22 = new org.apache.dubbo.rpc.protocol.tri.rest.RestInitializeException;	$r24 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages EXTENSION_INIT_FAILED>;	$r23 = newarray (java.lang.Object)[2];	$r23[0] = r17;	$r23[1] = r1;	specialinvoke $r22.<org.apache.dubbo.rpc.protocol.tri.rest.RestInitializeException: void <init>(java.lang.Throwable,org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r21, $r24, $r23);	throw $r22
;block_num 4