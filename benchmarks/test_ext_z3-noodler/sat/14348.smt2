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

(declare-sort var2802 0)
(declare-sort var2709 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun setHeader/631267455 (var2802 String String) void)
(declare-const null-var2802 var2802)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var247 var2802) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter 
(assert (not (= var247 null-var2802)))
(declare-const var2014 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2014 null-String)))
(declare-const var2085 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2085 null-Int)))
(define-const var3996 String (String_valueOf/1240665136 var2085)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert true)
;(assert (setHeader/631267455 var247 var2014 var3996)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter: void setHeader(java.lang.String,java.lang.String)>(r1, $r2) 

(declare-const var247!1 var2802)
(declare-const var2014!1 String)
(declare-const var3996!1 String)
 ; Statement: return 
(check-sat)
; {String_valueOf/1240665136=([int], java.lang.String), setHeader/631267455=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter, java.lang.String, java.lang.String], void)}
; {var2802=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter, var247=r0, var2014=r1, var2709=null_type, var2085=i0, var3996=$r2}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter=var2802, r0=var247, r1=var2014, null_type=var2709, i0=var2085, $r2=var3996}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter: void setHeader(java.lang.String,java.lang.String)>(r1, $r2);	return
;block_num 1