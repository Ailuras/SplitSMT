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

(declare-sort var1684 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1154451609 (var1684) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-const null-var1684 var1684)
(declare-const var367 var1684) ; Statement: r0 := @this: org.antlr.v4.codegen.model.decl.Decl 
(assert (not (= var367 null-var1684)))
(define-const var1439 String (name/1154451609 var367)) ; Statement: $r1 = r0.<org.antlr.v4.codegen.model.decl.Decl: java.lang.String name> 
(assert true)
(define-const var2407 Int (hashCode/-467973558 var1439)) ; Statement: $i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>() 
 ; Statement: return $i0 
(check-sat)
; {name/1154451609=([org.antlr.v4.codegen.model.decl.Decl], java.lang.String), hashCode/-467973558=([java.lang.String], int)}
; {var1684=org.antlr.v4.codegen.model.decl.Decl, var367=r0, var1439=$r1, var2407=$i0}
; {org.antlr.v4.codegen.model.decl.Decl=var1684, r0=var367, $r1=var1439, $i0=var2407}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.model.decl.Decl;	$r1 = r0.<org.antlr.v4.codegen.model.decl.Decl: java.lang.String name>;	$i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>();	return $i0
;block_num 1