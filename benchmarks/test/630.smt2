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

(declare-sort var2176 0)
(declare-sort var191 0)
(declare-sort var1373 0)
(declare-sort var2048 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCodeGenerator/1822649198 (var1373) var191)
(declare-fun cast-from-var2176-to-var1373 (var2176) var1373)
(declare-fun g/229379286 (var191) var2048)
(declare-fun getType/-1564681410 (var2048) Int)
(declare-const null-var2176 var2176)
(declare-const null-Bool Bool)
(declare-const var2176-$assertionsDisabled Bool)
(declare-const var3565 var2176) ; Statement: r0 := @this: org.antlr.v4.codegen.target.GoTarget 
(assert (not (= var3565 null-var2176)))
(declare-const var961 Bool) ; Statement: z3 := @parameter0: boolean 
(assert (not (= var961 null-Bool)))
(assert true)
(define-const var2631 var191 (getCodeGenerator/1822649198 (cast-from-var2176-to-var1373 var3565))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(define-const var2601 var2048 (g/229379286 var2631)) ; Statement: r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g> 
(define-const var2139 Bool var2176-$assertionsDisabled) ; Statement: $z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled> 
 ; Statement: if $z0 != 0 goto $i0 = virtualinvoke r2.<org.antlr.v4.tool.Grammar: int getType()>() 
(assert (not (= (ite var2139 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var1577 Int (getType/-1564681410 var2601)) ; Statement: $i0 = virtualinvoke r2.<org.antlr.v4.tool.Grammar: int getType()>() 
 ; Statement: lookupswitch($i0) {     case 31: goto $r11 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     case 44: goto $r6 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     case 72: goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     default: goto return "INVALID_FILE_NAME"; } 
(assert (and (not (= var1577 72)) (and (not (= var1577 44)) (and (not (= var1577 31)) true)))) ; Intersect: Negate: Cond: $i0 == 72   and Intersect: Negate: Cond: $i0 == 44   and Intersect: Negate: Cond: $i0 == 31   and Non Conditional   
 ; Statement: return "INVALID_FILE_NAME" 
(check-sat)
; {getCodeGenerator/1822649198=([org.antlr.v4.codegen.Target], org.antlr.v4.codegen.CodeGenerator), cast-from-var2176-to-var1373=([org.antlr.v4.codegen.target.GoTarget], org.antlr.v4.codegen.Target), g/229379286=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.tool.Grammar), getType/-1564681410=([org.antlr.v4.tool.Grammar], int)}
; {var2176=org.antlr.v4.codegen.target.GoTarget, var3565=r0, var961=z3, var191=org.antlr.v4.codegen.CodeGenerator, var1373=org.antlr.v4.codegen.Target, var2631=r1, var2048=org.antlr.v4.tool.Grammar, var2601=r2, var2139=$z0, var1577=$i0}
; {org.antlr.v4.codegen.target.GoTarget=var2176, r0=var3565, z3=var961, org.antlr.v4.codegen.CodeGenerator=var191, org.antlr.v4.codegen.Target=var1373, r1=var2631, org.antlr.v4.tool.Grammar=var2048, r2=var2601, $z0=var2139, $i0=var1577}
;seq 
;cnt {}
;stmts r0 := @this: org.antlr.v4.codegen.target.GoTarget;	z3 := @parameter0: boolean;	r1 = virtualinvoke r0.<org.antlr.v4.codegen.target.GoTarget: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	r2 = r1.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.tool.Grammar g>;	$z0 = <org.antlr.v4.codegen.target.GoTarget: boolean $assertionsDisabled>;	if $z0 != 0 goto $i0 = virtualinvoke r2.<org.antlr.v4.tool.Grammar: int getType()>();	$i0 = virtualinvoke r2.<org.antlr.v4.tool.Grammar: int getType()>();	lookupswitch($i0) {     case 31: goto $r11 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     case 44: goto $r6 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     case 72: goto $r3 = r2.<org.antlr.v4.tool.Grammar: java.lang.String name>;     default: goto return "INVALID_FILE_NAME"; };	return "INVALID_FILE_NAME"
;block_num 3