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

(declare-sort var149 0)
(declare-sort var3462 0)
(declare-sort var1781 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun future/364746903 (var149) var3462)
(declare-fun String_valueOf/-333372740 (var1781) String)
(declare-fun cast-from-String-to-var1781 (String) var1781)
(declare-fun complete/-1366664053 (var3462 var1781) Bool)
(declare-const null-var149 var149)
(declare-const null-String String)
(declare-const var1336 var149) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener 
(assert (not (= var1336 null-var149)))
(declare-const var1653 String) ; Statement: r1 := @parameter0: java.lang.CharSequence 
(assert (not (= var1653 null-String)))
(define-const var3175 var3462 (future/364746903 var1336)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener: java.util.concurrent.CompletableFuture future> 
(define-const var416 String (String_valueOf/-333372740 (cast-from-String-to-var1781 var1653))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r1) 
(assert true)
;(assert (complete/-1366664053 var3175 (cast-from-String-to-var1781 var416))) ; Statement: virtualinvoke $r2.<java.util.concurrent.CompletableFuture: boolean complete(java.lang.Object)>($r3) 

(declare-const var3175!1 var3462)
(declare-const var416!1 String)
 ; Statement: return 
(check-sat)
; {future/364746903=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener], java.util.concurrent.CompletableFuture), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-String-to-var1781=([java.lang.CharSequence], java.lang.Object), complete/-1366664053=([java.util.concurrent.CompletableFuture, java.lang.Object], boolean)}
; {var149=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener, var1336=r0, var1653=r1, var3462=java.util.concurrent.CompletableFuture, var3175=$r2, var1781=java.lang.Object, var416=$r3}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener=var149, r0=var1336, r1=var1653, java.util.concurrent.CompletableFuture=var3462, $r2=var3175, java.lang.Object=var1781, $r3=var416}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener;	r1 := @parameter0: java.lang.CharSequence;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.NegotiateClientCall$Listener: java.util.concurrent.CompletableFuture future>;	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r1);	virtualinvoke $r2.<java.util.concurrent.CompletableFuture: boolean complete(java.lang.Object)>($r3);	return
;block_num 1