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

(declare-sort var1371 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getHostAddress/-86611291 (var1371) String)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-const null-var1371 var1371)
(declare-const var3703 var1371) ; Statement: r0 := @parameter0: java.net.Inet6Address 
(assert (not (= var3703 null-var1371)))
(assert true)
(define-const var1324 String (getHostAddress/-86611291 var3703)) ; Statement: r1 = virtualinvoke r0.<java.net.Inet6Address: java.lang.String getHostAddress()>() 
(assert true)
(define-const var2463 Int (lastIndexOf/-1292097097 var1324 37)) ; Statement: i0 = virtualinvoke r1.<java.lang.String: int lastIndexOf(int)>(37) 
 ; Statement: if i0 <= 0 goto return r0 
(assert (<= var2463 0)) ; Cond: i0 <= 0 
 ; Statement: return r0 
(check-sat)
; {getHostAddress/-86611291=([java.net.Inet6Address], java.lang.String), lastIndexOf/-1292097097=([java.lang.String, int], int)}
; {var1371=java.net.Inet6Address, var3703=r0, var1324=r1, var2463=i0}
; {java.net.Inet6Address=var1371, r0=var3703, r1=var1324, i0=var2463}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r0 := @parameter0: java.net.Inet6Address;	r1 = virtualinvoke r0.<java.net.Inet6Address: java.lang.String getHostAddress()>();	i0 = virtualinvoke r1.<java.lang.String: int lastIndexOf(int)>(37);	if i0 <= 0 goto return r0;	return r0
;block_num 2