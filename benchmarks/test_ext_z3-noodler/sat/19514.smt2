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

(declare-sort var3777 0)
(declare-sort var3965 0)
(declare-sort var2721 0)
(declare-sort var2425 0)
(declare-sort var602 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun invokers/-1714667604 (var3777) var2425)
(declare-fun var2425_get/1088891777 (var2425 var3965) var3965)
(declare-fun cast-from-String-to-var3965 (String) var3965)
(declare-fun cast-from-var3965-to-var602 (var3965) var602)
(declare-fun var602_invoke/-1641478899 (var602 var3965 String (Array Int ClassObject) (Array Int var3965)) var3965)
(declare-const null-var3777 var3777)
(declare-const null-var3965 var3965)
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-__Array__Int__var3965__ (Array Int var3965))
(declare-const null-var602 var602)
(declare-const var616 var3777) ; Statement: r0 := @this: org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker 
(assert (not (= var616 null-var3777)))
(declare-const var2166 var3965) ; Statement: r5 := @parameter0: java.lang.Object 
(assert (not (= var2166 null-var3965)))
(declare-const var785 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var785 null-String)))
(declare-const var738 (Array Int ClassObject)) ; Statement: r6 := @parameter2: java.lang.Class[] 
(assert (not (= var738 null-__Array__Int__ClassObject__)))
(declare-const var430 (Array Int var3965)) ; Statement: r7 := @parameter3: java.lang.Object[] 
(assert (not (= var430 null-__Array__Int__var3965__)))
(define-const var1205 var2425 (invokers/-1714667604 var616)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker: java.util.Map invokers> 
(define-const var2633 var3965 (var2425_get/1088891777 var1205 (cast-from-String-to-var3965 var785))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var3620 var602 (cast-from-var3965-to-var602 var2633)) ; Statement: r4 = (org.apache.dubbo.rpc.proxy.MethodInvoker) $r3 
 ; Statement: if r4 != null goto $r8 = interfaceinvoke r4.<org.apache.dubbo.rpc.proxy.MethodInvoker: java.lang.Object invoke(java.lang.Object,java.lang.String,java.lang.Class[],java.lang.Object[])>(r5, r1, r6, r7) 
(assert (not (= var3620 null-var602))) ; Cond: r4 != null 
(define-const var2149 var3965 (var602_invoke/-1641478899 var3620 var2166 var785 var738 var430)) ; Statement: $r8 = interfaceinvoke r4.<org.apache.dubbo.rpc.proxy.MethodInvoker: java.lang.Object invoke(java.lang.Object,java.lang.String,java.lang.Class[],java.lang.Object[])>(r5, r1, r6, r7) 
 ; Statement: return $r8 
(check-sat)
; {invokers/-1714667604=([org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker], java.util.Map), var2425_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3965=([java.lang.String], java.lang.Object), cast-from-var3965-to-var602=([java.lang.Object], org.apache.dubbo.rpc.proxy.MethodInvoker), var602_invoke/-1641478899=([org.apache.dubbo.rpc.proxy.MethodInvoker, java.lang.Object, java.lang.String, java.lang.Class[], java.lang.Object[]], java.lang.Object)}
; {var3777=org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker, var616=r0, var3965=java.lang.Object, var2166=r5, var785=r1, var2721=null_type, var738=r6, var430=r7, var2425=java.util.Map, var1205=$r2, var2633=$r3, var602=org.apache.dubbo.rpc.proxy.MethodInvoker, var3620=r4, var2149=$r8}
; {org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker=var3777, r0=var616, java.lang.Object=var3965, r5=var2166, r1=var785, null_type=var2721, r6=var738, r7=var430, java.util.Map=var2425, $r2=var1205, $r3=var2633, org.apache.dubbo.rpc.proxy.MethodInvoker=var602, r4=var3620, $r8=var2149}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker;	r5 := @parameter0: java.lang.Object;	r1 := @parameter1: java.lang.String;	r6 := @parameter2: java.lang.Class[];	r7 := @parameter3: java.lang.Object[];	$r2 = r0.<org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker: java.util.Map invokers>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r4 = (org.apache.dubbo.rpc.proxy.MethodInvoker) $r3;	if r4 != null goto $r8 = interfaceinvoke r4.<org.apache.dubbo.rpc.proxy.MethodInvoker: java.lang.Object invoke(java.lang.Object,java.lang.String,java.lang.Class[],java.lang.Object[])>(r5, r1, r6, r7);	$r8 = interfaceinvoke r4.<org.apache.dubbo.rpc.proxy.MethodInvoker: java.lang.Object invoke(java.lang.Object,java.lang.String,java.lang.Class[],java.lang.Object[])>(r5, r1, r6, r7);	return $r8
;block_num 2