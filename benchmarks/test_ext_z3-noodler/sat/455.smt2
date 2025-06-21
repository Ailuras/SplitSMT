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

(declare-sort var353 0)
(declare-sort var452 0)
(declare-sort var936 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun boundingBoxWidth/1203940574 (var353) Int)
(declare-fun boundingBoxHeight/1203940574 (var353) Int)
(declare-fun arr-var936-init () (Array Int var936))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var936 (Int) var936)
(declare-fun String_format/-647569892 (var452 String (Array Int var936)) String)
(declare-fun boundingBox/1203940574 (var353) String)
(declare-const null-var353 var353)
(declare-const null-Int Int)
(declare-const var452-US var452)
(declare-const null-__Array__Int__var936__ (Array Int var936))
(declare-const var2855 var353) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var2855 null-var353)))
(declare-const var3536 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3536 null-Int)))
(declare-const var1208 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var1208 null-Int)))
(declare-const var2855!1 var353)
(assert (not (= var2855!1 null-var353)))
(assert (= (boundingBoxWidth/1203940574 var2855!1) var3536)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: int boundingBoxWidth> = i0 
(declare-const var2855!2 var353)
(assert (not (= var2855!2 null-var353)))
(assert (= (boundingBoxHeight/1203940574 var2855!2) var1208)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: int boundingBoxHeight> = i1 
(define-const var1853 var452 var452-US) ; Statement: $r2 = <java.util.Locale: java.util.Locale US> 
(define-const var1023 (Array Int var936) arr-var936-init) ; Statement: $r1 = newarray (java.lang.Object)[4] 
(define-const var1486 Int (Int_valueOf/-1371140006 0)) ; Statement: $r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(0) 
(declare-const var1023!1 (Array Int var936))
(assert (not (= var1023!1 null-__Array__Int__var936__)))
(assert (= (select var1023!1 0) (cast-from-Int-to-var936 var1486))) ; Statement: $r1[0] = $r3 
(define-const var127 Int (Int_valueOf/-1371140006 0)) ; Statement: $r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(0) 
(declare-const var1023!2 (Array Int var936))
(assert (not (= var1023!2 null-__Array__Int__var936__)))
(assert (= (select var1023!2 1) (cast-from-Int-to-var936 var127))) ; Statement: $r1[1] = $r4 
(define-const var974 Int (boundingBoxWidth/1203940574 var2855!2)) ; Statement: $i2 = r0.<org.antlr.v4.gui.PostScriptDocument: int boundingBoxWidth> 
(define-const var1950 Int (Int_valueOf/-1371140006 var974)) ; Statement: $r5 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i2) 
(declare-const var1023!3 (Array Int var936))
(assert (not (= var1023!3 null-__Array__Int__var936__)))
(assert (= (select var1023!3 2) (cast-from-Int-to-var936 var1950))) ; Statement: $r1[2] = $r5 
(define-const var2948 Int (boundingBoxHeight/1203940574 var2855!2)) ; Statement: $i3 = r0.<org.antlr.v4.gui.PostScriptDocument: int boundingBoxHeight> 
(define-const var386 Int (Int_valueOf/-1371140006 var2948)) ; Statement: $r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i3) 
(declare-const var1023!4 (Array Int var936))
(assert (not (= var1023!4 null-__Array__Int__var936__)))
(assert (= (select var1023!4 3) (cast-from-Int-to-var936 var386))) ; Statement: $r1[3] = $r6 
(define-const var1738 String (String_format/-647569892 var1853 "%%%%BoundingBox: %d %d %d %d\n" var1023!4)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r2, "%%%%BoundingBox: %d %d %d %d\n", $r1) 
(declare-const var2855!3 var353)
(assert (not (= var2855!3 null-var353)))
(assert (= (boundingBox/1203940574 var2855!3) var1738)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.String boundingBox> = $r7 
 ; Statement: return 
(check-sat)
; {boundingBoxWidth/1203940574=([org.antlr.v4.gui.PostScriptDocument], int), boundingBoxHeight/1203940574=([org.antlr.v4.gui.PostScriptDocument], int), arr-var936-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var936=([java.lang.Integer], java.lang.Object), String_format/-647569892=([java.util.Locale, java.lang.String, java.lang.Object[]], java.lang.String), boundingBox/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.String)}
; {var353=org.antlr.v4.gui.PostScriptDocument, var2855=r0, var3536=i0, var1208=i1, var452=java.util.Locale, var1853=$r2, var936=java.lang.Object, var1023=$r1, var1486=$r3, var127=$r4, var974=$i2, var1950=$r5, var2948=$i3, var386=$r6, var1738=$r7}
; {org.antlr.v4.gui.PostScriptDocument=var353, r0=var2855, i0=var3536, i1=var1208, java.util.Locale=var452, $r2=var1853, java.lang.Object=var936, $r1=var1023, $r3=var1486, $r4=var127, $i2=var974, $r5=var1950, $i3=var2948, $r6=var386, $r7=var1738}
;seq <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	i0 := @parameter0: int;	i1 := @parameter1: int;	r0.<org.antlr.v4.gui.PostScriptDocument: int boundingBoxWidth> = i0;	r0.<org.antlr.v4.gui.PostScriptDocument: int boundingBoxHeight> = i1;	$r2 = <java.util.Locale: java.util.Locale US>;	$r1 = newarray (java.lang.Object)[4];	$r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(0);	$r1[0] = $r3;	$r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(0);	$r1[1] = $r4;	$i2 = r0.<org.antlr.v4.gui.PostScriptDocument: int boundingBoxWidth>;	$r5 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i2);	$r1[2] = $r5;	$i3 = r0.<org.antlr.v4.gui.PostScriptDocument: int boundingBoxHeight>;	$r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i3);	$r1[3] = $r6;	$r7 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r2, "%%%%BoundingBox: %d %d %d %d\n", $r1);	r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.String boundingBox> = $r7;	return
;block_num 1