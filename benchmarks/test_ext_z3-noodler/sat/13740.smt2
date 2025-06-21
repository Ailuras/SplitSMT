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

(declare-sort var2686 0)
(declare-sort var2501 0)
(declare-sort var2616 0)
(declare-sort var3684 0)
(declare-sort var1691 0)
(declare-sort var1126 0)
(declare-sort var3829 0)
(declare-sort var3480 0)
(declare-sort var2131 0)
(declare-sort var2941 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameters/786304519 (var2501) (Array Int var1126))
(declare-fun getLength-Arr-var1126-1 ((Array Int var1126)) Int)
(declare-fun arr-var3829-init () (Array Int var3829))
(declare-fun var2131-init () var2131)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMethod/-647956321 (var2501) var2941)
(declare-fun append/-1031950772 (String var3829) String)
(declare-fun cast-from-var2941-to-var3829 (var2941) var3829)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-978807439 (var2131 String var2616) void)
(declare-fun cast-from-var3480-to-var2616 (var3480) var2616)
(declare-const null-var2686 var2686)
(declare-const null-var2501 var2501)
(declare-const null-var2616 var2616)
(declare-const null-var3684 var3684)
(declare-const null-var1691 var1691)
(declare-const null-var3480 var3480)
(declare-const var2318 var2686) ; Statement: r15 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.SpringResponseRestFilter 
(assert (not (= var2318 null-var2686)))
(declare-const var3988 var2501) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta 
(assert (not (= var3988 null-var2501)))
(declare-const var1359 var2616) ; Statement: r13 := @parameter1: java.lang.Throwable 
(assert (not (= var1359 null-var2616)))
(declare-const var3232 var3684) ; Statement: r16 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3232 null-var3684)))
(declare-const var2526 var1691) ; Statement: r17 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var2526 null-var1691)))
(assert true)
(define-const var1700 (Array Int var1126) (getParameters/786304519 var3988)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta[] getParameters()>() 
(define-const var1172 Int (getLength-Arr-var1126-1 var1700)) ; Statement: i0 = lengthof r1 
(define-const var1736 (Array Int var3829) arr-var3829-init) ; Statement: r2 = newarray (java.lang.Object)[i0] 
(define-const var1395 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: java.lang.reflect.Method getMethod()>() 
(assert (not (>= var1395 var1172))) ; Negate: Cond: i2 >= i0  
(declare-const var682 var3480) ; Statement: $r20 := @caughtexception 
(assert (not (= var682 null-var3480)))
(define-const var2488 var2131 var2131-init) ; Statement: $r21 = new org.apache.dubbo.rpc.protocol.tri.rest.RestException 
(define-const var679 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var679)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var679!1 String)
(assert (= var679!1 ""))
(assert true)
(define-const var2209 String (append/672562846 var679!1 "Failed to invoke exception handler method: ")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke exception handler method: ") 
(declare-const var679!2 String)
(assert (= var679!2 (str.++ var679!1 "Failed to invoke exception handler method: ")))
(assert true)
(define-const var171 var2941 (getMethod/-647956321 var3988)) ; Statement: $r23 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: java.lang.reflect.Method getMethod()>() 
(assert true)
(define-const var920 String (append/-1031950772 var2209 (cast-from-var2941-to-var3829 var171))) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var2209!1 String)
(assert (str.prefixof var2209 var2209!1))
(assert true)
(define-const var218 String (toString/-2075883882 var920)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-978807439 var2488 var218 (cast-from-var3480-to-var2616 var682))) ; Statement: specialinvoke $r21.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: void <init>(java.lang.String,java.lang.Throwable)>($r26, $r20) 

(declare-const var2488!1 var2131)
(declare-const var218!1 String)
(declare-const var682!1 var3480)
 ; Statement: throw $r21 
(check-sat)
; {getParameters/786304519=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta[]), getLength-Arr-var1126-1=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta[]], int), arr-var3829-init=([], java.lang.Object[]), var2131-init=([], org.apache.dubbo.rpc.protocol.tri.rest.RestException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMethod/-647956321=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta], java.lang.reflect.Method), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2941-to-var3829=([java.lang.reflect.Method], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-978807439=([org.apache.dubbo.rpc.protocol.tri.rest.RestException, java.lang.String, java.lang.Throwable], void), cast-from-var3480-to-var2616=([java.lang.Exception], java.lang.Throwable)}
; {var2686=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.SpringResponseRestFilter, var2318=r15, var2501=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta, var3988=r0, var2616=java.lang.Throwable, var1359=r13, var3684=org.apache.dubbo.remoting.http12.HttpRequest, var3232=r16, var1691=org.apache.dubbo.remoting.http12.HttpResponse, var2526=r17, var1126=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var1700=r1, var1172=i0, var3829=java.lang.Object, var1736=r2, var1395=i2, var3480=java.lang.Exception, var682=$r20, var2131=org.apache.dubbo.rpc.protocol.tri.rest.RestException, var2488=$r21, var679=$r22, var2209=$r24, var2941=java.lang.reflect.Method, var171=$r23, var920=$r25, var218=$r26}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.SpringResponseRestFilter=var2686, r15=var2318, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta=var2501, r0=var3988, java.lang.Throwable=var2616, r13=var1359, org.apache.dubbo.remoting.http12.HttpRequest=var3684, r16=var3232, org.apache.dubbo.remoting.http12.HttpResponse=var1691, r17=var2526, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var1126, r1=var1700, i0=var1172, java.lang.Object=var3829, r2=var1736, i2=var1395, java.lang.Exception=var3480, $r20=var682, org.apache.dubbo.rpc.protocol.tri.rest.RestException=var2131, $r21=var2488, $r22=var679, $r24=var2209, java.lang.reflect.Method=var2941, $r23=var171, $r25=var920, $r26=var218}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r15 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.SpringResponseRestFilter;	r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta;	r13 := @parameter1: java.lang.Throwable;	r16 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest;	r17 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse;	r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta[] getParameters()>();	i0 = lengthof r1;	r2 = newarray (java.lang.Object)[i0];	i2 = 0;	if i2 >= i0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: java.lang.reflect.Method getMethod()>();	$r20 := @caughtexception;	$r21 = new org.apache.dubbo.rpc.protocol.tri.rest.RestException;	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke exception handler method: ");	$r23 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: java.lang.reflect.Method getMethod()>();	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r21.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: void <init>(java.lang.String,java.lang.Throwable)>($r26, $r20);	throw $r21
;block_num 3