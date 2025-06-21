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

(declare-sort var1956 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/2041112302 (var1956) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun parameterTypes/2041112302 (var1956) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-const null-var1956 var1956)
(declare-const var1711 var1956) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key 
(assert (not (= var1711 null-var1956)))
(define-const var2792 String (name/2041112302 var1711)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.String name> 
(assert true)
(define-const var1968 Int (hashCode/-467973558 var2792)) ; Statement: i3 = virtualinvoke $r1.<java.lang.String: int hashCode()>() 
(define-const var1350 (Array Int ClassObject) (parameterTypes/2041112302 var1711)) ; Statement: r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.Class[] parameterTypes> 
(define-const var1156 Int (getLength-Arr-ClassObject-1 var1350)) ; Statement: i0 = lengthof r2 
(define-const var2706 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i0 goto return i3 
(assert (>= var2706 var1156)) ; Cond: i4 >= i0 
 ; Statement: return i3 
(check-sat)
; {name/2041112302=([org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key], java.lang.String), hashCode/-467973558=([java.lang.String], int), parameterTypes/2041112302=([org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int)}
; {var1956=org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key, var1711=r0, var2792=$r1, var1968=i3, var1350=r2, var1156=i0, var2706=i4}
; {org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key=var1956, r0=var1711, $r1=var2792, i3=var1968, r2=var1350, i0=var1156, i4=var2706}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.String name>;	i3 = virtualinvoke $r1.<java.lang.String: int hashCode()>();	r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.Class[] parameterTypes>;	i0 = lengthof r2;	i4 = 0;	if i4 >= i0 goto return i3;	return i3
;block_num 3