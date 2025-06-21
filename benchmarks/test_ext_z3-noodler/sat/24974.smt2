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

(declare-sort var3902 0)
(declare-sort var24 0)
(declare-sort var2634 0)
(declare-sort var2690 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun description/195094363 (var3902) String)
(declare-fun code/195094363 (var3902) var2634)
(declare-fun toString/1761020461 (var2690) String)
(declare-fun cast-from-var2634-to-var2690 (var2634) var2690)
(declare-const null-var3902 var3902)
(declare-const null-String String)
(declare-const var640 var3902) ; Statement: r0 := @this: org.apache.dubbo.rpc.TriRpcStatus 
(assert (not (= var640 null-var3902)))
(define-const var1313 String (description/195094363 var640)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description> 
 ; Statement: if $r1 == null goto $r2 = r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code> 
(assert (= var1313 null-String)) ; Cond: $r1 == null 
(define-const var2515 var2634 (code/195094363 var640)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code> 
(assert true)
(define-const var403 String (toString/1761020461 (cast-from-var2634-to-var2690 var2515))) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus$Code: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {description/195094363=([org.apache.dubbo.rpc.TriRpcStatus], java.lang.String), code/195094363=([org.apache.dubbo.rpc.TriRpcStatus], org.apache.dubbo.rpc.TriRpcStatus$Code), toString/1761020461=([java.lang.Enum], java.lang.String), cast-from-var2634-to-var2690=([org.apache.dubbo.rpc.TriRpcStatus$Code], java.lang.Enum)}
; {var3902=org.apache.dubbo.rpc.TriRpcStatus, var640=r0, var1313=$r1, var24=null_type, var2634=org.apache.dubbo.rpc.TriRpcStatus$Code, var2515=$r2, var2690=java.lang.Enum, var403=$r3}
; {org.apache.dubbo.rpc.TriRpcStatus=var3902, r0=var640, $r1=var1313, null_type=var24, org.apache.dubbo.rpc.TriRpcStatus$Code=var2634, $r2=var2515, java.lang.Enum=var2690, $r3=var403}
;seq <java.lang.Enum: java.lang.String toString()>
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.TriRpcStatus;	$r1 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description>;	if $r1 == null goto $r2 = r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code>;	$r2 = r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus$Code: java.lang.String toString()>();	return $r3
;block_num 2