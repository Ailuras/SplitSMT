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

(declare-sort var2228 0)
(declare-sort var1986 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addHeader/-1797004038 (var2228 String String) void)
(declare-const null-var2228 var2228)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1708 var2228) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter 
(assert (not (= var1708 null-var2228)))
(declare-const var702 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var702 null-String)))
(declare-const var3879 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3879 null-Int)))
(define-const var1285 String (String_valueOf/1240665136 var3879)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert true)
;(assert (addHeader/-1797004038 var1708 var702 var1285)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter: void addHeader(java.lang.String,java.lang.String)>(r1, $r2) 

(declare-const var1708!1 var2228)
(declare-const var702!1 String)
(declare-const var1285!1 String)
 ; Statement: return 
(check-sat)
; {String_valueOf/1240665136=([int], java.lang.String), addHeader/-1797004038=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter, java.lang.String, java.lang.String], void)}
; {var2228=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter, var1708=r0, var702=r1, var1986=null_type, var3879=i0, var1285=$r2}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter=var2228, r0=var1708, r1=var702, null_type=var1986, i0=var3879, $r2=var1285}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter: void addHeader(java.lang.String,java.lang.String)>(r1, $r2);	return
;block_num 1