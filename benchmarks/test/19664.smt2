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

(declare-sort var3801 0)
(declare-sort var515 0)
(declare-sort var3140 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun root/1436675366 (var3801) var3140)
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun isEndOfWord/1436493706 (var3140) Bool)
(declare-const null-var3801 var3801)
(declare-const null-String String)
(declare-const var155 var3801) ; Statement: r0 := @this: org.apache.dubbo.rpc.support.TrieTree 
(assert (not (= var155 null-var3801)))
(declare-const var3252 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3252 null-String)))
(define-const var361 var3140 (root/1436675366 var155)) ; Statement: r6 = r0.<org.apache.dubbo.rpc.support.TrieTree: org.apache.dubbo.rpc.support.TrieNode root> 
(assert true)
(define-const var2630 (Array Int Int) (toCharArray/415275702 var3252)) ; Statement: r2 = virtualinvoke r1.<java.lang.String: char[] toCharArray()>() 
(define-const var101 Int (getLength-Arr-Int-1 var2630)) ; Statement: i0 = lengthof r2 
(define-const var2418 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto $z0 = r6.<org.apache.dubbo.rpc.support.TrieNode: boolean isEndOfWord> 
(assert (>= var2418 var101)) ; Cond: i3 >= i0 
(define-const var3065 Bool (isEndOfWord/1436493706 var361)) ; Statement: $z0 = r6.<org.apache.dubbo.rpc.support.TrieNode: boolean isEndOfWord> 
 ; Statement: return $z0 
(check-sat)
; {root/1436675366=([org.apache.dubbo.rpc.support.TrieTree], org.apache.dubbo.rpc.support.TrieNode), toCharArray/415275702=([java.lang.String], char[]), getLength-Arr-Int-1=([char[]], int), isEndOfWord/1436493706=([org.apache.dubbo.rpc.support.TrieNode], boolean)}
; {var3801=org.apache.dubbo.rpc.support.TrieTree, var155=r0, var3252=r1, var515=null_type, var3140=org.apache.dubbo.rpc.support.TrieNode, var361=r6, var2630=r2, var101=i0, var2418=i3, var3065=$z0}
; {org.apache.dubbo.rpc.support.TrieTree=var3801, r0=var155, r1=var3252, null_type=var515, org.apache.dubbo.rpc.support.TrieNode=var3140, r6=var361, r2=var2630, i0=var101, i3=var2418, $z0=var3065}
;seq <java.lang.String: char[] toCharArray()>
;cnt {"<java.lang.String: char[] toCharArray()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.support.TrieTree;	r1 := @parameter0: java.lang.String;	r6 = r0.<org.apache.dubbo.rpc.support.TrieTree: org.apache.dubbo.rpc.support.TrieNode root>;	r2 = virtualinvoke r1.<java.lang.String: char[] toCharArray()>();	i0 = lengthof r2;	i3 = 0;	if i3 >= i0 goto $z0 = r6.<org.apache.dubbo.rpc.support.TrieNode: boolean isEndOfWord>;	$z0 = r6.<org.apache.dubbo.rpc.support.TrieNode: boolean isEndOfWord>;	return $z0
;block_num 3