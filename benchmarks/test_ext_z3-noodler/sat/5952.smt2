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

(declare-sort var2063 0)
(declare-sort var370 0)
(declare-sort var3833 0)
(declare-sort var1875 0)
(declare-sort var2040 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3833) void)
(declare-fun cast-from-var2063-to-var3833 (var2063) var3833)
(declare-fun var1875-init () var1875)
(declare-fun <init>/-2175807 (var1875) void)
(declare-fun cast-from-var1875-to-var2040 (var1875) var2040)
(declare-fun attributeMap/-2043001730 (var2063) var2040)
(declare-fun method/-2043001730 (var2063) var370)
(declare-fun getParameterTypes/827748249 (var370) (Array Int ClassObject))
(declare-fun parameterClasses/-2043001730 (var2063) (Array Int ClassObject))
(declare-fun getReturnType/-1494237887 (var370) ClassObject)
(declare-fun returnClass/-2043001730 (var2063) ClassObject)
(declare-fun createParamSignature/-1913127437 (var2063 (Array Int ClassObject)) (Array Int String))
(declare-fun parameterTypes/-2043001730 (var2063) (Array Int String))
(declare-fun getName/1227988463 (var370) String)
(declare-fun methodName/-2043001730 (var2063) String)
(declare-fun generic/-2043001730 (var2063) Bool)
(declare-const null-var2063 var2063)
(declare-const null-var370 var370)
(declare-const var2519 var2063) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ConsumerMethodModel 
(assert (not (= var2519 null-var2063)))
(declare-const var1869 var370) ; Statement: r2 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1869 null-var370)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2063-to-var3833 var2519))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2519!1 var2063)
(define-const var1206 var1875 var1875-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1206)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1206!1 var1875)
(declare-const var2519!2 var2063)
(assert (not (= var2519!2 null-var2063)))
(assert (= (attributeMap/-2043001730 var2519!2) (cast-from-var1875-to-var2040 var1206!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.util.concurrent.ConcurrentMap attributeMap> = $r1 
(declare-const var2519!3 var2063)
(assert (not (= var2519!3 null-var2063)))
(assert (= (method/-2043001730 var2519!3) var1869)) ; Statement: r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.reflect.Method method> = r2 
(assert true)
(define-const var3765 (Array Int ClassObject) (getParameterTypes/827748249 var1869)) ; Statement: $r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(declare-const var2519!4 var2063)
(assert (not (= var2519!4 null-var2063)))
(assert (= (parameterClasses/-2043001730 var2519!4) var3765)) ; Statement: r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.Class[] parameterClasses> = $r3 
(assert true)
(define-const var927 ClassObject (getReturnType/-1494237887 var1869)) ; Statement: $r4 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(declare-const var2519!5 var2063)
(assert (not (= var2519!5 null-var2063)))
(assert (= (returnClass/-2043001730 var2519!5) var927)) ; Statement: r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.Class returnClass> = $r4 
(define-const var3058 (Array Int ClassObject) (parameterClasses/-2043001730 var2519!5)) ; Statement: $r5 = r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.Class[] parameterClasses> 
(assert true)
(define-const var3556 (Array Int String) (createParamSignature/-1913127437 var2519!5 var3058)) ; Statement: $r6 = specialinvoke r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.String[] createParamSignature(java.lang.Class[])>($r5) 
(declare-const var2519!6 var2063)
(assert (not (= var2519!6 null-var2063)))
(assert (= (parameterTypes/-2043001730 var2519!6) var3556)) ; Statement: r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.String[] parameterTypes> = $r6 
(assert true)
(define-const var2108 String (getName/1227988463 var1869)) ; Statement: $r7 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>() 
(declare-const var2519!7 var2063)
(assert (not (= var2519!7 null-var2063)))
(assert (= (methodName/-2043001730 var2519!7) var2108)) ; Statement: r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.String methodName> = $r7 
(define-const var368 String (methodName/-2043001730 var2519!7)) ; Statement: $r8 = r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.String methodName> 
(assert true)
(define-const var2700 Bool (= var368 "$invoke")) ; Statement: $z0 = virtualinvoke $r8.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 == 0 goto $z1 = 0 
(assert (= (ite var2700 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1709 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
(declare-const var2519!8 var2063)
(assert (not (= var2519!8 null-var2063)))
(assert (= (generic/-2043001730 var2519!8) var1709)) ; Statement: r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: boolean generic> = $z1 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2063-to-var3833=([org.apache.dubbo.rpc.model.ConsumerMethodModel], java.lang.Object), var1875-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1875-to-var2040=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), attributeMap/-2043001730=([org.apache.dubbo.rpc.model.ConsumerMethodModel], java.util.concurrent.ConcurrentMap), method/-2043001730=([org.apache.dubbo.rpc.model.ConsumerMethodModel], java.lang.reflect.Method), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), parameterClasses/-2043001730=([org.apache.dubbo.rpc.model.ConsumerMethodModel], java.lang.Class[]), getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), returnClass/-2043001730=([org.apache.dubbo.rpc.model.ConsumerMethodModel], java.lang.Class), createParamSignature/-1913127437=([org.apache.dubbo.rpc.model.ConsumerMethodModel, java.lang.Class[]], java.lang.String[]), parameterTypes/-2043001730=([org.apache.dubbo.rpc.model.ConsumerMethodModel], java.lang.String[]), getName/1227988463=([java.lang.reflect.Method], java.lang.String), methodName/-2043001730=([org.apache.dubbo.rpc.model.ConsumerMethodModel], java.lang.String), generic/-2043001730=([org.apache.dubbo.rpc.model.ConsumerMethodModel], boolean)}
; {var2063=org.apache.dubbo.rpc.model.ConsumerMethodModel, var2519=r0, var370=java.lang.reflect.Method, var1869=r2, var3833=java.lang.Object, var1875=java.util.concurrent.ConcurrentHashMap, var1206=$r1, var2040=java.util.concurrent.ConcurrentMap, var3765=$r3, var927=$r4, var3058=$r5, var3556=$r6, var2108=$r7, var368=$r8, var2700=$z0, var1709=$z1}
; {org.apache.dubbo.rpc.model.ConsumerMethodModel=var2063, r0=var2519, java.lang.reflect.Method=var370, r2=var1869, java.lang.Object=var3833, java.util.concurrent.ConcurrentHashMap=var1875, $r1=var1206, java.util.concurrent.ConcurrentMap=var2040, $r3=var3765, $r4=var927, $r5=var3058, $r6=var3556, $r7=var2108, $r8=var368, $z0=var2700, $z1=var1709}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ConsumerMethodModel;	r2 := @parameter0: java.lang.reflect.Method;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.util.concurrent.ConcurrentMap attributeMap> = $r1;	r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.reflect.Method method> = r2;	$r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.Class[] parameterClasses> = $r3;	$r4 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.Class returnClass> = $r4;	$r5 = r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.Class[] parameterClasses>;	$r6 = specialinvoke r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.String[] createParamSignature(java.lang.Class[])>($r5);	r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.String[] parameterTypes> = $r6;	$r7 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>();	r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.String methodName> = $r7;	$r8 = r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: java.lang.String methodName>;	$z0 = virtualinvoke $r8.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 == 0 goto $z1 = 0;	$z1 = 0;	r0.<org.apache.dubbo.rpc.model.ConsumerMethodModel: boolean generic> = $z1;	return
;block_num 3