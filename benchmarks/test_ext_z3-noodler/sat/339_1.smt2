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

(declare-sort var1832 0)
(declare-sort var3046 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1154451609 (var3046) String)
(declare-fun cast-from-var1832-to-var3046 (var1832) var3046)
(declare-fun hashCode/-467973558 (String) Int)
(declare-const null-var1832 var1832)
(declare-const var2470 var1832) ; Statement: r0 := @this: org.antlr.v4.codegen.model.decl.AltLabelStructDecl 
(assert (not (= var2470 null-var1832)))
(define-const var3823 String (name/1154451609 (cast-from-var1832-to-var3046 var2470))) ; Statement: $r1 = r0.<org.antlr.v4.codegen.model.decl.AltLabelStructDecl: java.lang.String name> 
(assert true)
(define-const var3980 Int (hashCode/-467973558 var3823)) ; Statement: $i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>() 
 ; Statement: return $i0 
(check-sat)
; {name/1154451609=([org.antlr.v4.codegen.model.decl.Decl], java.lang.String), cast-from-var1832-to-var3046=([org.antlr.v4.codegen.model.decl.AltLabelStructDecl], org.antlr.v4.codegen.model.decl.Decl), hashCode/-467973558=([java.lang.String], int)}
; {var1832=org.antlr.v4.codegen.model.decl.AltLabelStructDecl, var2470=r0, var3046=org.antlr.v4.codegen.model.decl.Decl, var3823=$r1, var3980=$i0}
; {org.antlr.v4.codegen.model.decl.AltLabelStructDecl=var1832, r0=var2470, org.antlr.v4.codegen.model.decl.Decl=var3046, $r1=var3823, $i0=var3980}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.model.decl.AltLabelStructDecl;	$r1 = r0.<org.antlr.v4.codegen.model.decl.AltLabelStructDecl: java.lang.String name>;	$i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>();	return $i0
;block_num 1