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

(declare-sort var3972 0)
(declare-sort var1458 0)
(declare-sort var3672 0)
(declare-sort var3970 0)
(declare-sort var2568 0)
(declare-sort var479 0)
(declare-sort var3279 0)
(declare-sort var1382 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getUrl/-307611182 (var3972) var3672)
(declare-fun var1458_getMethodName/-888969971 (var1458) String)
(declare-fun getMethodParameter/2015795402 (var3672 String String) String)
(declare-fun var3970_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2568-init () var2568)
(declare-fun var479-init () var479)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun url/-514244350 (var3972) var3672)
(declare-fun append/-1031950772 (String var3279) String)
(declare-fun cast-from-var3672-to-var3279 (var3672) var3279)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/807490927 (var479 String) void)
(declare-fun <init>/-92512204 (var2568 var1382) void)
(declare-fun cast-from-var479-to-var1382 (var479) var1382)
(declare-const null-var3972 var3972)
(declare-const null-var1458 var1458)
(declare-const var2615 var3972) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.MockInvoker 
(assert (not (= var2615 null-var3972)))
(declare-const var2922 var1458) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2922 null-var1458)))
(define-const var333 Bool true) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (= (ite var333 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3601 var3672 (getUrl/-307611182 var2615)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var1720 String (var1458_getMethodName/-888969971 var2922)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var1661 String (getMethodParameter/2015795402 var3601 var1720 "mock")) ; Statement: $r22 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>($r2, "mock") 
(define-const var3807 Bool (var3970_isBlank/-523695098 (cast-from-String-to-String var1661))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r22) 
 ; Statement: if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String decode(java.lang.String)>($r22) 
(assert (not (= (ite var3807 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3471 var2568 var2568-init) ; Statement: $r14 = new org.apache.dubbo.rpc.RpcException 
(define-const var3327 var479 var479-init) ; Statement: $r15 = new java.lang.IllegalAccessException 
(define-const var1029 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1029)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1029!1 String)
(assert (= var1029!1 ""))
(assert true)
(define-const var3539 String (append/672562846 var1029!1 "mock can not be null. url :")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("mock can not be null. url :") 
(declare-const var1029!2 String)
(assert (= var1029!2 (str.++ var1029!1 "mock can not be null. url :")))
(define-const var2322 var3672 (url/-514244350 var2615)) ; Statement: $r17 = r1.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var2940 String (append/-1031950772 var3539 (cast-from-var3672-to-var3279 var2322))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r17) 
(declare-const var3539!1 String)
(assert (str.prefixof var3539 var3539!1))
(assert true)
(define-const var3146 String (toString/-2075883882 var2940)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/807490927 var3327 var3146)) ; Statement: specialinvoke $r15.<java.lang.IllegalAccessException: void <init>(java.lang.String)>($r20) 

(declare-const var3327!1 var479)
(declare-const var3146!1 String)
(assert true)
;(assert (<init>/-92512204 var3471 (cast-from-var479-to-var1382 var3327!1))) ; Statement: specialinvoke $r14.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.Throwable)>($r15) 

(declare-const var3471!1 var2568)
(declare-const var3327!2 var479)
 ; Statement: throw $r14 
(check-sat)
; {getUrl/-307611182=([org.apache.dubbo.rpc.support.MockInvoker], org.apache.dubbo.common.URL), var1458_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3970_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2568-init=([], org.apache.dubbo.rpc.RpcException), var479-init=([], java.lang.IllegalAccessException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), url/-514244350=([org.apache.dubbo.rpc.support.MockInvoker], org.apache.dubbo.common.URL), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3672-to-var3279=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/807490927=([java.lang.IllegalAccessException, java.lang.String], void), <init>/-92512204=([org.apache.dubbo.rpc.RpcException, java.lang.Throwable], void), cast-from-var479-to-var1382=([java.lang.IllegalAccessException], java.lang.Throwable)}
; {var3972=org.apache.dubbo.rpc.support.MockInvoker, var2615=r1, var1458=org.apache.dubbo.rpc.Invocation, var2922=r0, var333=$z0, var3672=org.apache.dubbo.common.URL, var3601=$r3, var1720=$r2, var1661=$r22, var3970=org.apache.dubbo.common.utils.StringUtils, var3807=$z1, var2568=org.apache.dubbo.rpc.RpcException, var3471=$r14, var479=java.lang.IllegalAccessException, var3327=$r15, var1029=$r16, var3539=$r18, var2322=$r17, var3279=java.lang.Object, var2940=$r19, var3146=$r20, var1382=java.lang.Throwable}
; {org.apache.dubbo.rpc.support.MockInvoker=var3972, r1=var2615, org.apache.dubbo.rpc.Invocation=var1458, r0=var2922, $z0=var333, org.apache.dubbo.common.URL=var3672, $r3=var3601, $r2=var1720, $r22=var1661, org.apache.dubbo.common.utils.StringUtils=var3970, $z1=var3807, org.apache.dubbo.rpc.RpcException=var2568, $r14=var3471, java.lang.IllegalAccessException=var479, $r15=var3327, $r16=var1029, $r18=var3539, $r17=var2322, java.lang.Object=var3279, $r19=var2940, $r20=var3146, java.lang.Throwable=var1382}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.MockInvoker;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$z0 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation;	if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL getUrl()>();	$r3 = virtualinvoke r1.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$r22 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>($r2, "mock");	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r22);	if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String decode(java.lang.String)>($r22);	$r14 = new org.apache.dubbo.rpc.RpcException;	$r15 = new java.lang.IllegalAccessException;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("mock can not be null. url :");	$r17 = r1.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r15.<java.lang.IllegalAccessException: void <init>(java.lang.String)>($r20);	specialinvoke $r14.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.Throwable)>($r15);	throw $r14
;block_num 3