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

(declare-sort var1518 0)
(declare-sort var2122 0)
(declare-sort var1637 0)
(declare-sort var201 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun scheduling/1236144978 (var1518) var201)
(declare-fun compareAndSet/-351715474 (var201 Bool Bool) Bool)
(declare-const null-var1518 var1518)
(declare-const null-String String)
(declare-const null-var1637 var1637)
(declare-const var1759 var1518) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient 
(assert (not (= var1759 null-var1518)))
(declare-const var57 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var57 null-String)))
(declare-const var3825 var1637) ; Statement: r0 := @parameter1: java.lang.Throwable 
(assert (not (= var3825 null-var1637)))
 ; Statement: if r0 != null goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.util.concurrent.atomic.AtomicBoolean scheduling> 
(assert (not (= var3825 null-var1637))) ; Cond: r0 != null 
(define-const var2682 var201 (scheduling/1236144978 var1759)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.util.concurrent.atomic.AtomicBoolean scheduling> 
(assert true)
(define-const var1505 Bool (compareAndSet/-351715474 var2682 (ite (= 1 0) true false) (ite (= 1 1) true false))) ; Statement: $z0 = virtualinvoke $r2.<java.util.concurrent.atomic.AtomicBoolean: boolean compareAndSet(boolean,boolean)>(0, 1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var1505 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {scheduling/1236144978=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], java.util.concurrent.atomic.AtomicBoolean), compareAndSet/-351715474=([java.util.concurrent.atomic.AtomicBoolean, boolean, boolean], boolean)}
; {var1518=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient, var1759=r1, var57=r3, var2122=null_type, var1637=java.lang.Throwable, var3825=r0, var201=java.util.concurrent.atomic.AtomicBoolean, var2682=$r2, var1505=$z0}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient=var1518, r1=var1759, r3=var57, null_type=var2122, java.lang.Throwable=var1637, r0=var3825, java.util.concurrent.atomic.AtomicBoolean=var201, $r2=var2682, $z0=var1505}
;seq 
;cnt {}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient;	r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Throwable;	if r0 != null goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.util.concurrent.atomic.AtomicBoolean scheduling>;	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.util.concurrent.atomic.AtomicBoolean scheduling>;	$z0 = virtualinvoke $r2.<java.util.concurrent.atomic.AtomicBoolean: boolean compareAndSet(boolean,boolean)>(0, 1);	if $z0 == 0 goto return;	return
;block_num 3