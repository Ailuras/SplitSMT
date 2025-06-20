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

(declare-sort var523 0)
(declare-sort var3887 0)
(declare-sort var2639 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3887_isEmpty/-813097145 (String) Bool)
(declare-fun var2639_normalize/1164371542 (String) String)
(declare-const null-String String)
(declare-const var1271 String) ; Statement: r10 := @parameter0: java.lang.String 
(assert (not (= var1271 null-String)))
(declare-const var530 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var530 null-String)))
(define-const var533 Bool (var3887_isEmpty/-813097145 var1271)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
(assert (= (ite var533 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2747 Bool (var3887_isEmpty/-813097145 var530)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z1 == 0 goto $c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0) 
(assert (not (= (ite var2747 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var1768 String (var2639_normalize/1164371542 var1271)) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.util.PathUtils: java.lang.String normalize(java.lang.String)>(r10) 
 ; Statement: return $r9 
(check-sat)
; {var3887_isEmpty/-813097145=([java.lang.String], boolean), var2639_normalize/1164371542=([java.lang.String], java.lang.String)}
; {var1271=r10, var523=null_type, var530=r0, var3887=org.apache.dubbo.common.utils.StringUtils, var533=$z0, var2747=$z1, var2639=org.apache.dubbo.rpc.protocol.tri.rest.util.PathUtils, var1768=$r9}
; {r10=var1271, null_type=var523, r0=var530, org.apache.dubbo.common.utils.StringUtils=var3887, $z0=var533, $z1=var2747, org.apache.dubbo.rpc.protocol.tri.rest.util.PathUtils=var2639, $r9=var1768}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r10 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z1 == 0 goto $c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.util.PathUtils: java.lang.String normalize(java.lang.String)>(r10);	return $r9
;block_num 3