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

(declare-sort var1822 0)
(declare-sort var2959 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1822 var1822)
(declare-const null-String String)
(declare-const var736 var1822) ; Statement: r1 := @this: com.alibaba.dubbo.container.page.ResourceFilter 
(assert (not (= var736 null-var1822)))
(declare-const var3399 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3399 null-String)))
(assert true)
(define-const var653 Bool (startsWith/-1785782452 var3399 "/")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("/") 
 ; Statement: if $z0 != 0 goto $z1 = 1 
(assert (not (= (ite var653 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1759 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1822=com.alibaba.dubbo.container.page.ResourceFilter, var736=r1, var3399=r0, var2959=null_type, var653=$z0, var1759=$z1}
; {com.alibaba.dubbo.container.page.ResourceFilter=var1822, r1=var736, r0=var3399, null_type=var2959, $z0=var653, $z1=var1759}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.container.page.ResourceFilter;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("/");	if $z0 != 0 goto $z1 = 1;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3