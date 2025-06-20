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

(declare-sort var3965 0)
(declare-sort var707 0)
(declare-sort var1198 0)
(declare-sort var988 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/1762336425 (var3965) var1198)
(declare-fun getText/-791554220 (var1198 var707) String)
(declare-fun doc/-1930180878 (var1198) var988)
(declare-fun getLineHeight/1985812787 (var988) Float64)
(declare-fun nodeHeightPaddingAbove/-1930180878 (var1198) Int)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-fun nodeHeightPaddingBelow/-1930180878 (var1198) Int)
(declare-const null-var3965 var3965)
(declare-const null-var707 var707)
(declare-const var1561 var3965) ; Statement: r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide 
(assert (not (= var1561 null-var3965)))
(declare-const var824 var707) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var824 null-var707)))
(define-const var1905 var1198 (this$0/1762336425 var1561)) ; Statement: $r2 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(assert true)
(define-const var905 String (getText/-791554220 var1905 var824)) ; Statement: r3 = virtualinvoke $r2.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var878 var1198 (this$0/1762336425 var1561)) ; Statement: $r4 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var255 var988 (doc/-1930180878 var878)) ; Statement: $r5 = $r4.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc> 
(assert true)
(define-const var2231 Float64 (getLineHeight/1985812787 var255)) ; Statement: $d1 = virtualinvoke $r5.<org.antlr.v4.gui.PostScriptDocument: double getLineHeight()>() 
(define-const var1228 var1198 (this$0/1762336425 var1561)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var3311 Int (nodeHeightPaddingAbove/-1930180878 var1228)) ; Statement: $i0 = $r6.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingAbove> 
(define-const var613 Float64 (cast-from-Int-to-Float64 var3311)) ; Statement: $d0 = (double) $i0 
(define-const var120 Float64 (fp.add roundNearestTiesToEven var2231 var613)) ; Statement: $d3 = $d1 + $d0 
(define-const var3621 var1198 (this$0/1762336425 var1561)) ; Statement: $r7 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var1313 Int (nodeHeightPaddingBelow/-1930180878 var3621)) ; Statement: $i1 = $r7.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow> 
(define-const var1457 Float64 (cast-from-Int-to-Float64 var1313)) ; Statement: $d2 = (double) $i1 
(define-const var2025 Float64 (fp.add roundNearestTiesToEven var120 var1457)) ; Statement: d4 = $d3 + $d2 
; split operation: var3091 = var905.split("\n") ; Statement: r8 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var3912 Int (get_split_length var905 "\n" -1)) ; Statement: $i2 = lengthof r8 
(define-const var3222 Float64 (cast-from-Int-to-Float64 var3912)) ; Statement: $d5 = (double) $i2 
(define-const var1358 Float64 (fp.mul roundNearestTiesToEven var2025 var3222)) ; Statement: $d6 = d4 * $d5 
 ; Statement: return $d6 
(check-sat)
; {this$0/1762336425=([org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide], org.antlr.v4.gui.TreePostScriptGenerator), getText/-791554220=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.lang.String), doc/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], org.antlr.v4.gui.PostScriptDocument), getLineHeight/1985812787=([org.antlr.v4.gui.PostScriptDocument], double), nodeHeightPaddingAbove/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int), cast-from-Int-to-Float64=([int], double), nodeHeightPaddingBelow/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int)}
; {var3965=org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide, var1561=r0, var707=org.antlr.v4.runtime.tree.Tree, var824=r1, var1198=org.antlr.v4.gui.TreePostScriptGenerator, var1905=$r2, var905=r3, var878=$r4, var988=org.antlr.v4.gui.PostScriptDocument, var255=$r5, var2231=$d1, var1228=$r6, var3311=$i0, var613=$d0, var120=$d3, var3621=$r7, var1313=$i1, var1457=$d2, var2025=d4, var3091=r8, var3912=$i2, var3222=$d5, var1358=$d6}
; {org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide=var3965, r0=var1561, org.antlr.v4.runtime.tree.Tree=var707, r1=var824, org.antlr.v4.gui.TreePostScriptGenerator=var1198, $r2=var1905, r3=var905, $r4=var878, org.antlr.v4.gui.PostScriptDocument=var988, $r5=var255, $d1=var2231, $r6=var1228, $i0=var3311, $d0=var613, $d3=var120, $r7=var3621, $i1=var1313, $d2=var1457, d4=var2025, r8=var3091, $i2=var3912, $d5=var3222, $d6=var1358}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide;	r1 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	r3 = virtualinvoke $r2.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r4 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$r5 = $r4.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc>;	$d1 = virtualinvoke $r5.<org.antlr.v4.gui.PostScriptDocument: double getLineHeight()>();	$r6 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$i0 = $r6.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingAbove>;	$d0 = (double) $i0;	$d3 = $d1 + $d0;	$r7 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$i1 = $r7.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow>;	$d2 = (double) $i1;	d4 = $d3 + $d2;	r8 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$i2 = lengthof r8;	$d5 = (double) $i2;	$d6 = d4 * $d5;	return $d6
;block_num 1