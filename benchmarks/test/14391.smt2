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

(declare-sort var2895 0)
(declare-sort var2530 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addHeader/793730558 (var2895 String String) void)
(declare-const null-var2895 var2895)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var80 var2895) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter 
(assert (not (= var80 null-var2895)))
(declare-const var1869 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1869 null-String)))
(declare-const var748 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var748 null-Int)))
(define-const var3250 String (String_valueOf/1240665136 var748)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert true)
;(assert (addHeader/793730558 var80 var1869 var3250)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter: void addHeader(java.lang.String,java.lang.String)>(r1, $r2) 

(declare-const var80!1 var2895)
(declare-const var1869!1 String)
(declare-const var3250!1 String)
 ; Statement: return 
(check-sat)
; {String_valueOf/1240665136=([int], java.lang.String), addHeader/793730558=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter, java.lang.String, java.lang.String], void)}
; {var2895=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter, var80=r0, var1869=r1, var2530=null_type, var748=i0, var3250=$r2}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter=var2895, r0=var80, r1=var1869, null_type=var2530, i0=var748, $r2=var3250}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter: void addHeader(java.lang.String,java.lang.String)>(r1, $r2);	return
;block_num 1