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

(declare-sort var1286 0)
(declare-sort var2766 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun setHeader/-1959467141 (var1286 String String) void)
(declare-const null-var1286 var1286)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2036 var1286) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter 
(assert (not (= var2036 null-var1286)))
(declare-const var1479 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1479 null-String)))
(declare-const var2907 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2907 null-Int)))
(define-const var1944 String (String_valueOf/1240665136 var2907)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert true)
;(assert (setHeader/-1959467141 var2036 var1479 var1944)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter: void setHeader(java.lang.String,java.lang.String)>(r1, $r2) 

(declare-const var2036!1 var1286)
(declare-const var1479!1 String)
(declare-const var1944!1 String)
 ; Statement: return 
(check-sat)
; {String_valueOf/1240665136=([int], java.lang.String), setHeader/-1959467141=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter, java.lang.String, java.lang.String], void)}
; {var1286=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter, var2036=r0, var1479=r1, var2766=null_type, var2907=i0, var1944=$r2}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter=var1286, r0=var2036, r1=var1479, null_type=var2766, i0=var2907, $r2=var1944}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter: void setHeader(java.lang.String,java.lang.String)>(r1, $r2);	return
;block_num 1