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

(declare-sort var1476 0)
(declare-sort var183 0)
(declare-sort var2931 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2931) void)
(declare-fun cast-from-var1476-to-var2931 (var1476) var2931)
(declare-fun fontSize/1203940574 (var1476) Int)
(declare-fun lineWidth/1203940574 (var1476) Float64)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun ps/1203940574 (var1476) String)
(declare-fun closed/1203940574 (var1476) Bool)
(declare-fun header/1063112382 (var1476) String)
(declare-fun setFont/-1849888808 (var1476 String Int) void)
(declare-const null-var1476 var1476)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3131 var1476) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var3131 null-var1476)))
(declare-const var2892 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2892 null-String)))
(declare-const var1647 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1647 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1476-to-var2931 var3131))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3131!1 var1476)
(declare-const var3131!2 var1476)
(assert (not (= var3131!2 null-var1476)))
(assert (= (fontSize/1203940574 var3131!2) 12)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: int fontSize> = 12 
(declare-const var3131!3 var1476)
(assert (not (= var3131!3 null-var1476)))
(assert (= (lineWidth/1203940574 var3131!3) ((_ to_fp 11 53) #x3fd3333333333333))) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: double lineWidth> = 0.3 
(define-const var1084 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1084)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1084!1 String)
(assert (= var1084!1 ""))
(declare-const var3131!4 var1476)
(assert (not (= var3131!4 null-var1476)))
(assert (= (ps/1203940574 var3131!4) var1084!1)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> = $r1 
(declare-const var3131!5 var1476)
(assert (not (= var3131!5 null-var1476)))
(assert (= (closed/1203940574 var3131!5) (ite (= 1 0) true false))) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: boolean closed> = 0 
(assert true)
;(assert (header/1063112382 var3131!5)) ; Statement: virtualinvoke r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder header()>() 

(declare-const var3131!6 var1476)
(assert true)
;(assert (setFont/-1849888808 var3131!6 var2892 var1647)) ; Statement: virtualinvoke r0.<org.antlr.v4.gui.PostScriptDocument: void setFont(java.lang.String,int)>(r2, i0) 

(declare-const var3131!7 var1476)
(declare-const var2892!1 String)
(declare-const var1647!1 Int)
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1476-to-var2931=([org.antlr.v4.gui.PostScriptDocument], java.lang.Object), fontSize/1203940574=([org.antlr.v4.gui.PostScriptDocument], int), lineWidth/1203940574=([org.antlr.v4.gui.PostScriptDocument], double), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), closed/1203940574=([org.antlr.v4.gui.PostScriptDocument], boolean), header/1063112382=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), setFont/-1849888808=([org.antlr.v4.gui.PostScriptDocument, java.lang.String, int], void)}
; {var1476=org.antlr.v4.gui.PostScriptDocument, var3131=r0, var2892=r2, var183=null_type, var1647=i0, var2931=java.lang.Object, var1084=$r1}
; {org.antlr.v4.gui.PostScriptDocument=var1476, r0=var3131, r2=var2892, null_type=var183, i0=var1647, java.lang.Object=var2931, $r1=var1084}
;seq <java.lang.StringBuilder: void <init>()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	r2 := @parameter0: java.lang.String;	i0 := @parameter1: int;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.antlr.v4.gui.PostScriptDocument: int fontSize> = 12;	r0.<org.antlr.v4.gui.PostScriptDocument: double lineWidth> = 0.3;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> = $r1;	r0.<org.antlr.v4.gui.PostScriptDocument: boolean closed> = 0;	virtualinvoke r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder header()>();	virtualinvoke r0.<org.antlr.v4.gui.PostScriptDocument: void setFont(java.lang.String,int)>(r2, i0);	return
;block_num 1