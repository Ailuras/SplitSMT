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

(declare-sort var3309 0)
(declare-sort var3359 0)
(declare-sort var3760 0)
(declare-sort var1895 0)
(declare-sort var604 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBoundsOfNode/-98686064 (var3309 var3760) var1895)
(declare-fun x/-707491510 (var1895) Float64)
(declare-fun cast-from-Float64-to-String (Float64) String)
(declare-fun y/-707491510 (var1895) Float64)
(declare-fun width/-707491510 (var1895) Float64)
(declare-fun height/-707491510 (var1895) Float64)
(declare-fun var3309_rect/-1423990714 (String String String String String String) String)
(declare-fun write/654681022 (var3359 String) void)
(declare-fun getText/1718706454 (var3309 var3760) String)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun cast-from-Float64-to-Int (Float64) Int)
(declare-fun arr-var604-init () (Array Int var604))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var604 (Int) var604)
(declare-fun String_format/1339386452 (String (Array Int var604)) String)
(declare-fun cast-from-Int-to-String (Int) String)
(declare-fun var3309_text/49817839 (String String String String) String)
(declare-const null-var3309 var3309)
(declare-const null-var3359 var3359)
(declare-const null-var3760 var3760)
(declare-const null-__Array__Int__var604__ (Array Int var604))
(declare-const var3886 var3309) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer 
(assert (not (= var3886 null-var3309)))
(declare-const var112 var3359) ; Statement: r3 := @parameter0: java.io.Writer 
(assert (not (= var112 null-var3359)))
(declare-const var973 var3760) ; Statement: r1 := @parameter1: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var973 null-var3760)))
(assert true)
(define-const var1302 var1895 (getBoundsOfNode/-98686064 var3886 var973)) ; Statement: r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var2828 Float64 (x/-707491510 var1302)) ; Statement: $d0 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var2947 String (str.++ "\u0001" (cast-from-Float64-to-String var2828))) ; Statement: $r7 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (double)>($d0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001") 
(define-const var1341 Float64 (y/-707491510 var1302)) ; Statement: $d1 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var974 String (str.++ "\u0001" (cast-from-Float64-to-String var1341))) ; Statement: $r6 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (double)>($d1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001") 
(define-const var2199 Float64 (width/-707491510 var1302)) ; Statement: $d2 = r2.<java.awt.geom.Rectangle2D$Double: double width> 
(define-const var682 String (str.++ "\u0001" (cast-from-Float64-to-String var2199))) ; Statement: $r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (double)>($d2) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001") 
(define-const var1001 Float64 (height/-707491510 var1302)) ; Statement: $d3 = r2.<java.awt.geom.Rectangle2D$Double: double height> 
(define-const var3941 String (str.++ "\u0001" (cast-from-Float64-to-String var1001))) ; Statement: $r4 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (double)>($d3) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001") 
(define-const var3695 String (var3309_rect/-1423990714 var2947 var974 var682 var3941 "fill:orange; stroke:rgb(0,0,0);" "rx=\u00221\u0022")) ; Statement: $r8 = staticinvoke <org.antlr.v4.gui.TreeViewer: java.lang.String rect(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r7, $r6, $r5, $r4, "fill:orange; stroke:rgb(0,0,0);", "rx=\"1\"") 
(assert true)
;(assert (write/654681022 var112 var3695)) ; Statement: virtualinvoke r3.<java.io.Writer: void write(java.lang.String)>($r8) 

(declare-const var112!1 var3359)
(declare-const var3695!1 String)
(assert true)
(define-const var3592 String (getText/1718706454 var3886 var973)) ; Statement: $r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert true)
(define-const var588 String (replace/2138489945 var3592 (cast-from-String-to-String "<") (cast-from-String-to-String "&lt;"))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("<", "&lt;") 
(assert true)
(define-const var1983 String (replace/2138489945 var588 (cast-from-String-to-String ">") (cast-from-String-to-String "&gt;"))) ; Statement: r11 = virtualinvoke $r10.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>(">", "&gt;") 
(define-const var3436 Float64 (x/-707491510 var1302)) ; Statement: $d4 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var816 Int (cast-from-Float64-to-Int var3436)) ; Statement: $i0 = (int) $d4 
(define-const var3563 Int (+ var816 2)) ; Statement: i1 = $i0 + 2 
(define-const var329 Float64 (y/-707491510 var1302)) ; Statement: $d5 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var2507 Int (cast-from-Float64-to-Int var329)) ; Statement: $i2 = (int) $d5 
(define-const var655 Int (+ var2507 10)) ; Statement: $i3 = $i2 + 10 
(define-const var2626 Int (- var655 1)) ; Statement: i4 = $i3 - 1 
(define-const var1588 (Array Int var604) arr-var604-init) ; Statement: $r12 = newarray (java.lang.Object)[1] 
(define-const var2971 Int (Int_valueOf/-1371140006 10)) ; Statement: $r13 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(10) 
(declare-const var1588!1 (Array Int var604))
(assert (not (= var1588!1 null-__Array__Int__var604__)))
(assert (= (select var1588!1 0) (cast-from-Int-to-var604 var2971))) ; Statement: $r12[0] = $r13 
(define-const var2650 String (String_format/1339386452 "font-family:sans-serif;font-size:%dpx;" var1588!1)) ; Statement: r14 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("font-family:sans-serif;font-size:%dpx;", $r12) 
(define-const var2053 String (str.++ "\u0001" (cast-from-Int-to-String var3563))) ; Statement: $r16 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int)>(i1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001") 
(define-const var3776 String (str.++ "\u0001" (cast-from-Int-to-String var2626))) ; Statement: $r15 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int)>(i4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001") 
(define-const var881 String (var3309_text/49817839 var2053 var3776 var2650 var1983)) ; Statement: $r17 = staticinvoke <org.antlr.v4.gui.TreeViewer: java.lang.String text(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r16, $r15, r14, r11) 
(assert true)
;(assert (write/654681022 var112!1 var881)) ; Statement: virtualinvoke r3.<java.io.Writer: void write(java.lang.String)>($r17) 

(declare-const var112!2 var3359)
(declare-const var881!1 String)
 ; Statement: return 
(check-sat)
; {getBoundsOfNode/-98686064=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), cast-from-Float64-to-String=([double], java.lang.String), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), width/-707491510=([java.awt.geom.Rectangle2D$Double], double), height/-707491510=([java.awt.geom.Rectangle2D$Double], double), var3309_rect/-1423990714=([java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String], java.lang.String), write/654681022=([java.io.Writer, java.lang.String], void), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), cast-from-Float64-to-Int=([double], int), arr-var604-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var604=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), cast-from-Int-to-String=([int], java.lang.String), var3309_text/49817839=([java.lang.String, java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var3309=org.antlr.v4.gui.TreeViewer, var3886=r0, var3359=java.io.Writer, var112=r3, var3760=org.antlr.v4.runtime.tree.Tree, var973=r1, var1895=java.awt.geom.Rectangle2D$Double, var1302=r2, var2828=$d0, var2947=$r7, var1341=$d1, var974=$r6, var2199=$d2, var682=$r5, var1001=$d3, var3941=$r4, var3695=$r8, var3592=$r9, var588=$r10, var1983=r11, var3436=$d4, var816=$i0, var3563=i1, var329=$d5, var2507=$i2, var655=$i3, var2626=i4, var604=java.lang.Object, var1588=$r12, var2971=$r13, var2650=r14, var2053=$r16, var3776=$r15, var881=$r17}
; {org.antlr.v4.gui.TreeViewer=var3309, r0=var3886, java.io.Writer=var3359, r3=var112, org.antlr.v4.runtime.tree.Tree=var3760, r1=var973, java.awt.geom.Rectangle2D$Double=var1895, r2=var1302, $d0=var2828, $r7=var2947, $d1=var1341, $r6=var974, $d2=var2199, $r5=var682, $d3=var1001, $r4=var3941, $r8=var3695, $r9=var3592, $r10=var588, r11=var1983, $d4=var3436, $i0=var816, i1=var3563, $d5=var329, $i2=var2507, $i3=var655, i4=var2626, java.lang.Object=var604, $r12=var1588, $r13=var2971, r14=var2650, $r16=var2053, $r15=var3776, $r17=var881}
;seq <java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 2,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer;	r3 := @parameter0: java.io.Writer;	r1 := @parameter1: org.antlr.v4.runtime.tree.Tree;	r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	$d0 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$r7 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (double)>($d0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001");	$d1 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$r6 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (double)>($d1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001");	$d2 = r2.<java.awt.geom.Rectangle2D$Double: double width>;	$r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (double)>($d2) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001");	$d3 = r2.<java.awt.geom.Rectangle2D$Double: double height>;	$r4 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (double)>($d3) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001");	$r8 = staticinvoke <org.antlr.v4.gui.TreeViewer: java.lang.String rect(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r7, $r6, $r5, $r4, "fill:orange; stroke:rgb(0,0,0);", "rx=\"1\"");	virtualinvoke r3.<java.io.Writer: void write(java.lang.String)>($r8);	$r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r10 = virtualinvoke $r9.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("<", "&lt;");	r11 = virtualinvoke $r10.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>(">", "&gt;");	$d4 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i0 = (int) $d4;	i1 = $i0 + 2;	$d5 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i2 = (int) $d5;	$i3 = $i2 + 10;	i4 = $i3 - 1;	$r12 = newarray (java.lang.Object)[1];	$r13 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(10);	$r12[0] = $r13;	r14 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("font-family:sans-serif;font-size:%dpx;", $r12);	$r16 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int)>(i1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001");	$r15 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int)>(i4) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001");	$r17 = staticinvoke <org.antlr.v4.gui.TreeViewer: java.lang.String text(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r16, $r15, r14, r11);	virtualinvoke r3.<java.io.Writer: void write(java.lang.String)>($r17);	return
;block_num 1