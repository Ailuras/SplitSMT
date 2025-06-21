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

(declare-sort var93 0)
(declare-sort var2082 0)
(declare-sort var283 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun root/1436675366 (var93) var283)
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun isEndOfWord/1436493706 (var283) Bool)
(declare-const null-var93 var93)
(declare-const null-String String)
(declare-const null-var283 var283)
(declare-const var3923 var93) ; Statement: r0 := @this: org.apache.dubbo.rpc.support.TrieTree 
(assert (not (= var3923 null-var93)))
(declare-const var320 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var320 null-String)))
(define-const var1010 var283 (root/1436675366 var3923)) ; Statement: r8 = r0.<org.apache.dubbo.rpc.support.TrieTree: org.apache.dubbo.rpc.support.TrieNode root> 
(assert true)
(define-const var1305 (Array Int Int) (toCharArray/415275702 var320)) ; Statement: r2 = virtualinvoke r1.<java.lang.String: char[] toCharArray()>() 
(define-const var939 Int (getLength-Arr-Int-1 var1305)) ; Statement: i0 = lengthof r2 
(define-const var1013 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto r8.<org.apache.dubbo.rpc.support.TrieNode: boolean isEndOfWord> = 1 
(assert (>= var1013 var939)) ; Cond: i3 >= i0 
(declare-const var1010!1 var283)
(assert (not (= var1010!1 null-var283)))
(assert (= (isEndOfWord/1436493706 var1010!1) (ite (= 1 1) true false))) ; Statement: r8.<org.apache.dubbo.rpc.support.TrieNode: boolean isEndOfWord> = 1 
 ; Statement: return 
(check-sat)
; {root/1436675366=([org.apache.dubbo.rpc.support.TrieTree], org.apache.dubbo.rpc.support.TrieNode), toCharArray/415275702=([java.lang.String], char[]), getLength-Arr-Int-1=([char[]], int), isEndOfWord/1436493706=([org.apache.dubbo.rpc.support.TrieNode], boolean)}
; {var93=org.apache.dubbo.rpc.support.TrieTree, var3923=r0, var320=r1, var2082=null_type, var283=org.apache.dubbo.rpc.support.TrieNode, var1010=r8, var1305=r2, var939=i0, var1013=i3}
; {org.apache.dubbo.rpc.support.TrieTree=var93, r0=var3923, r1=var320, null_type=var2082, org.apache.dubbo.rpc.support.TrieNode=var283, r8=var1010, r2=var1305, i0=var939, i3=var1013}
;seq <java.lang.String: char[] toCharArray()>
;cnt {"<java.lang.String: char[] toCharArray()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.support.TrieTree;	r1 := @parameter0: java.lang.String;	r8 = r0.<org.apache.dubbo.rpc.support.TrieTree: org.apache.dubbo.rpc.support.TrieNode root>;	r2 = virtualinvoke r1.<java.lang.String: char[] toCharArray()>();	i0 = lengthof r2;	i3 = 0;	if i3 >= i0 goto r8.<org.apache.dubbo.rpc.support.TrieNode: boolean isEndOfWord> = 1;	r8.<org.apache.dubbo.rpc.support.TrieNode: boolean isEndOfWord> = 1;	return
;block_num 3