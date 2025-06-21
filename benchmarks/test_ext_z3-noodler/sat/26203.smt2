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

(declare-sort var1910 0)
(declare-sort var2298 0)
(declare-sort var3152 0)
(declare-sort var1715 0)
(declare-sort var3005 0)
(declare-sort var3067 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun walkHierarchy/1516966022 (var1910 ClassObject) void)
(declare-fun classes/1671169235 (var1910) var3152)
(declare-fun var3005_bootstrap$/283380325 (var1910) var1715)
(declare-fun var2298_accept/-49180496 (var2298 var3067 var3067) void)
(declare-fun cast-from-var3152-to-var3067 (var3152) var3067)
(declare-fun cast-from-var1715-to-var3067 (var1715) var3067)
(declare-const null-var1910 var1910)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2298 var2298)
(declare-const var3385 var1910) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker 
(assert (not (= var3385 null-var1910)))
(declare-const var343 ClassObject) ; Statement: r5 := @parameter0: java.lang.Class 
(assert (not (= var343 null-ClassObject)))
(declare-const var2736 var2298) ; Statement: r2 := @parameter1: java.util.function.BiConsumer 
(assert (not (= var2736 null-var2298)))
(assert true)
(define-const var1298 String (getName/-1958580599 var343)) ; Statement: $r0 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2331 Bool (contains/1009244746 var1298 (cast-from-String-to-String "$$"))) ; Statement: $z0 = virtualinvoke $r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("$$") 
 ; Statement: if $z0 == 0 goto specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker: void walkHierarchy(java.lang.Class)>(r5) 
(assert (= (ite var2331 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (walkHierarchy/1516966022 var3385 var343)) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker: void walkHierarchy(java.lang.Class)>(r5) 

(declare-const var3385!1 var1910)
(declare-const var343!1 ClassObject)
(define-const var2249 var3152 (classes/1671169235 var3385!1)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker: java.util.Set classes> 
(define-const var1473 var1715 (var3005_bootstrap$/283380325 var3385!1)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$lambda_walk_0__1472: java.util.function.Consumer bootstrap$(org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker)>(r1) 
;(assert (var2298_accept/-49180496 var2736 (cast-from-var3152-to-var3067 var2249) (cast-from-var1715-to-var3067 var1473))) ; Statement: interfaceinvoke r2.<java.util.function.BiConsumer: void accept(java.lang.Object,java.lang.Object)>($r3, $r4) 

(declare-const var2736!1 var2298)
(declare-const var2249!1 var3152)
(declare-const var1473!1 var1715)
 ; Statement: return 
(check-sat)
; {getName/-1958580599=([java.lang.Class], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), walkHierarchy/1516966022=([org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker, java.lang.Class], void), classes/1671169235=([org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker], java.util.Set), var3005_bootstrap$/283380325=([org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker], java.util.function.Consumer), var2298_accept/-49180496=([java.util.function.BiConsumer, java.lang.Object, java.lang.Object], void), cast-from-var3152-to-var3067=([java.util.Set], java.lang.Object), cast-from-var1715-to-var3067=([java.util.function.Consumer], java.lang.Object)}
; {var1910=org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker, var3385=r1, var343=r5, var2298=java.util.function.BiConsumer, var2736=r2, var1298=$r0, var2331=$z0, var3152=java.util.Set, var2249=$r3, var1715=java.util.function.Consumer, var3005=org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$lambda_walk_0__1472, var1473=$r4, var3067=java.lang.Object}
; {org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker=var1910, r1=var3385, r5=var343, java.util.function.BiConsumer=var2298, r2=var2736, $r0=var1298, $z0=var2331, java.util.Set=var3152, $r3=var2249, java.util.function.Consumer=var1715, org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$lambda_walk_0__1472=var3005, $r4=var1473, java.lang.Object=var3067}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker;	r5 := @parameter0: java.lang.Class;	r2 := @parameter1: java.util.function.BiConsumer;	$r0 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$z0 = virtualinvoke $r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("$$");	if $z0 == 0 goto specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker: void walkHierarchy(java.lang.Class)>(r5);	specialinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker: void walkHierarchy(java.lang.Class)>(r5);	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker: java.util.Set classes>;	$r4 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$lambda_walk_0__1472: java.util.function.Consumer bootstrap$(org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker)>(r1);	interfaceinvoke r2.<java.util.function.BiConsumer: void accept(java.lang.Object,java.lang.Object)>($r3, $r4);	return
;block_num 2