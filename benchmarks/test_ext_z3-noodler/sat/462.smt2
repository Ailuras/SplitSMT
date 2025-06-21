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

(declare-sort var2468 0)
(declare-sort var2466 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isFile/1016913701 (var2466) Bool)
(declare-const null-var2468 var2468)
(declare-const null-var2466 var2466)
(declare-const var1209 var2468) ; Statement: r2 := @this: org.antlr.v4.gui.TreeViewer$7 
(assert (not (= var1209 null-var2468)))
(declare-const var388 var2466) ; Statement: r0 := @parameter0: java.io.File 
(assert (not (= var388 null-var2466)))
(assert true)
(define-const var946 Bool (isFile/1016913701 var388)) ; Statement: $z0 = virtualinvoke r0.<java.io.File: boolean isFile()>() 
 ; Statement: if $z0 == 0 goto return 1 
(assert (= (ite var946 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 1 
(check-sat)
; {isFile/1016913701=([java.io.File], boolean)}
; {var2468=org.antlr.v4.gui.TreeViewer$7, var1209=r2, var2466=java.io.File, var388=r0, var946=$z0}
; {org.antlr.v4.gui.TreeViewer$7=var2468, r2=var1209, java.io.File=var2466, r0=var388, $z0=var946}
;seq 
;cnt {}
;stmts r2 := @this: org.antlr.v4.gui.TreeViewer$7;	r0 := @parameter0: java.io.File;	$z0 = virtualinvoke r0.<java.io.File: boolean isFile()>();	if $z0 == 0 goto return 1;	return 1
;block_num 2