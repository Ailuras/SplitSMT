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

(declare-sort var1126 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun subType/1926907315 (var1126) String)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-const null-var1126 var1126)
(declare-const var2643 var1126) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression 
(assert (not (= var2643 null-var1126)))
(define-const var3309 String (subType/1926907315 var2643)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType> 
(assert true)
(define-const var51 Int (lastIndexOf/-1292097097 var3309 43)) ; Statement: i0 = virtualinvoke $r1.<java.lang.String: int lastIndexOf(int)>(43) 
(define-const var2735 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
 ; Statement: if i0 == $i3 goto return null 
(assert (not (= var51 var2735))) ; Negate: Cond: i0 == $i3  
(define-const var1120 String (subType/1926907315 var2643)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType> 
(define-const var2417 Int (+ var51 1)) ; Statement: $i1 = i0 + 1 
(assert (not (and true (and (>= var2417 0) (>= (str.len var1120) var2417)))))
(check-sat)
; {subType/1926907315=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression], java.lang.String), lastIndexOf/-1292097097=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), substring/850833817=([java.lang.String, int], java.lang.String)}
; {var1126=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression, var2643=r0, var3309=$r1, var51=i0, var2735=$i3, var1120=$r2, var2417=$i1, var3392=$r3}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression=var1126, r0=var2643, $r1=var3309, i0=var51, $i3=var2735, $r2=var1120, $i1=var2417, $r3=var3392}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType>;	i0 = virtualinvoke $r1.<java.lang.String: int lastIndexOf(int)>(43);	$i3 = (int) -1;	if i0 == $i3 goto return null;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType>;	$i1 = i0 + 1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String substring(int)>($i1);	return $r3
;block_num 2