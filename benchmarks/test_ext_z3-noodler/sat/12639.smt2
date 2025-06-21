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

(declare-sort var2693 0)
(declare-sort var3425 0)
(declare-sort var2982 0)
(declare-sort var1486 0)
(declare-sort var996 0)
(declare-sort var3021 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMetadata/703324177 (var2982) var3425)
(declare-fun cast-from-var2693-to-var2982 (var2693) var2982)
(declare-fun getAttribute/-355102655 (var3425 String) var1486)
(declare-fun var996-init () var996)
(declare-fun <init>/1281898776 (var996) void)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var3021_toArray/-775711681 (var3021 (Array Int var1486)) (Array Int var1486))
(declare-fun cast-from-var996-to-var3021 (var996) var3021)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1486__ ((Array Int String)) (Array Int var1486))
(declare-fun cast-from-__Array__Int__var1486__-to-__Array__Int__String__ ((Array Int var1486)) (Array Int String))
(declare-fun String_join/-1520935655 (String (Array Int String)) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2693 var2693)
(declare-const var3826 var2693) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ConsumerModel 
(assert (not (= var3826 null-var2693)))
(assert true)
(define-const var26 var3425 (getServiceMetadata/703324177 (cast-from-var2693-to-var2982 var3826))) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>() 
(assert true)
(define-const var2750 var1486 (getAttribute/-355102655 var26 "currentClusterInvoker")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.Object getAttribute(java.lang.String)>("currentClusterInvoker") 
(define-const var1928 var996 var996-init) ; Statement: $r3 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var1928)) ; Statement: specialinvoke $r3.<java.util.LinkedList: void <init>()>() 

(declare-const var1928!1 var996)
(define-const var3756 Bool false) ; Statement: $z0 = r2 instanceof java.util.Map 
 ; Statement: if $z0 == 0 goto $r4 = newarray (java.lang.String)[0] 
(assert (= (ite var3756 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2515 (Array Int String) arr-String-init) ; Statement: $r4 = newarray (java.lang.String)[0] 
(define-const var1575 (Array Int var1486) (var3021_toArray/-775711681 (cast-from-var996-to-var3021 var1928!1) (cast-from-__Array__Int__String__-to-__Array__Int__var1486__ var2515))) ; Statement: $r5 = interfaceinvoke $r3.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r4) 
(define-const var2287 (Array Int String) (cast-from-__Array__Int__var1486__-to-__Array__Int__String__ var1575)) ; Statement: $r6 = (java.lang.CharSequence[]) $r5 
(define-const var3682 String (String_join/-1520935655 (cast-from-String-to-String "/") var2287)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>("/", $r6) 
 ; Statement: return $r7 
(check-sat)
; {getServiceMetadata/703324177=([org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.rpc.model.ServiceMetadata), cast-from-var2693-to-var2982=([org.apache.dubbo.rpc.model.ConsumerModel], org.apache.dubbo.rpc.model.ServiceModel), getAttribute/-355102655=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.String], java.lang.Object), var996-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), arr-String-init=([], java.lang.String[]), var3021_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-var996-to-var3021=([java.util.LinkedList], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var1486__=([java.lang.String[]], java.lang.Object[]), cast-from-__Array__Int__var1486__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.CharSequence[]), String_join/-1520935655=([java.lang.CharSequence, java.lang.CharSequence[]], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2693=org.apache.dubbo.rpc.model.ConsumerModel, var3826=r0, var3425=org.apache.dubbo.rpc.model.ServiceMetadata, var2982=org.apache.dubbo.rpc.model.ServiceModel, var26=$r1, var1486=java.lang.Object, var2750=r2, var996=java.util.LinkedList, var1928=$r3, var3756=$z0, var2515=$r4, var3021=java.util.List, var1575=$r5, var2287=$r6, var3682=$r7}
; {org.apache.dubbo.rpc.model.ConsumerModel=var2693, r0=var3826, org.apache.dubbo.rpc.model.ServiceMetadata=var3425, org.apache.dubbo.rpc.model.ServiceModel=var2982, $r1=var26, java.lang.Object=var1486, r2=var2750, java.util.LinkedList=var996, $r3=var1928, $z0=var3756, $r4=var2515, java.util.List=var3021, $r5=var1575, $r6=var2287, $r7=var3682}
;seq <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>
;cnt {"<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ConsumerModel;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.Object getAttribute(java.lang.String)>("currentClusterInvoker");	$r3 = new java.util.LinkedList;	specialinvoke $r3.<java.util.LinkedList: void <init>()>();	$z0 = r2 instanceof java.util.Map;	if $z0 == 0 goto $r4 = newarray (java.lang.String)[0];	$r4 = newarray (java.lang.String)[0];	$r5 = interfaceinvoke $r3.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r4);	$r6 = (java.lang.CharSequence[]) $r5;	$r7 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>("/", $r6);	return $r7
;block_num 2