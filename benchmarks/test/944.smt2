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

(declare-sort var2609 0)
(declare-sort var1431 0)
(declare-sort var895 0)
(declare-sort var2859 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun move/-1210150098 (var2609 Float64 Float64) void)
(declare-fun ps/1203940574 (var2609) String)
(declare-fun arr-var2859-init () (Array Int var2859))
(declare-fun cast-from-String-to-var2859 (String) var2859)
(declare-fun String_format/-647569892 (var895 String (Array Int var2859)) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun stroke/229331553 (var2609) void)
(declare-const null-var2609 var2609)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var895-US var895)
(declare-const null-__Array__Int__var2859__ (Array Int var2859))
(declare-const var2456 var2609) ; Statement: r2 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var2456 null-var2609)))
(declare-const var3409 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var3409 null-String)))
(declare-const var2893 Float64) ; Statement: d0 := @parameter1: double 
(assert (not (= var2893 null-Float64)))
(declare-const var970 Float64) ; Statement: d1 := @parameter2: double 
(assert (not (= var970 null-Float64)))
(define-const var1430 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1430)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1430!1 String)
(assert (= var1430!1 ""))
(assert true)
(define-const var2886 (Array Int Int) (toCharArray/415275702 var3409)) ; Statement: r1 = virtualinvoke r7.<java.lang.String: char[] toCharArray()>() 
(define-const var3283 Int (getLength-Arr-Int-1 var2886)) ; Statement: i0 = lengthof r1 
(define-const var2701 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto r8 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var2701 var3283)) ; Cond: i2 >= i0 
(assert true)
(define-const var794 String (toString/-2075883882 var1430!1)) ; Statement: r8 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (move/-1210150098 var2456 var2893 var970)) ; Statement: virtualinvoke r2.<org.antlr.v4.gui.PostScriptDocument: void move(double,double)>(d0, d1) 

(declare-const var2456!1 var2609)
(declare-const var2893!1 Float64)
(declare-const var970!1 Float64)
(define-const var241 String (ps/1203940574 var2456!1)) ; Statement: $r5 = r2.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(define-const var1582 var895 var895-US) ; Statement: $r4 = <java.util.Locale: java.util.Locale US> 
(define-const var1493 (Array Int var2859) arr-var2859-init) ; Statement: $r3 = newarray (java.lang.Object)[1] 
(declare-const var1493!1 (Array Int var2859))
(assert (not (= var1493!1 null-__Array__Int__var2859__)))
(assert (= (select var1493!1 0) (cast-from-String-to-var2859 var794))) ; Statement: $r3[0] = r8 
(define-const var3675 String (String_format/-647569892 var1582 "(%s) show\n" var1493!1)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r4, "(%s) show\n", $r3) 
(assert true)
;(assert (append/672562846 var241 var3675)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var241!1 String)
(assert (= var241!1 (str.++ var241 var3675)))
(assert true)
;(assert (stroke/229331553 var2456!1)) ; Statement: virtualinvoke r2.<org.antlr.v4.gui.PostScriptDocument: void stroke()>() 

(declare-const var2456!2 var2609)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toCharArray/415275702=([java.lang.String], char[]), getLength-Arr-Int-1=([char[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), move/-1210150098=([org.antlr.v4.gui.PostScriptDocument, double, double], void), ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), arr-var2859-init=([], java.lang.Object[]), cast-from-String-to-var2859=([java.lang.String], java.lang.Object), String_format/-647569892=([java.util.Locale, java.lang.String, java.lang.Object[]], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), stroke/229331553=([org.antlr.v4.gui.PostScriptDocument], void)}
; {var2609=org.antlr.v4.gui.PostScriptDocument, var2456=r2, var3409=r7, var1431=null_type, var2893=d0, var970=d1, var1430=$r9, var2886=r1, var3283=i0, var2701=i2, var794=r8, var241=$r5, var895=java.util.Locale, var1582=$r4, var2859=java.lang.Object, var1493=$r3, var3675=$r6}
; {org.antlr.v4.gui.PostScriptDocument=var2609, r2=var2456, r7=var3409, null_type=var1431, d0=var2893, d1=var970, $r9=var1430, r1=var2886, i0=var3283, i2=var2701, r8=var794, $r5=var241, java.util.Locale=var895, $r4=var1582, java.lang.Object=var2859, $r3=var1493, $r6=var3675}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: char[] toCharArray()>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: char[] toCharArray()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r2 := @this: org.antlr.v4.gui.PostScriptDocument;	r7 := @parameter0: java.lang.String;	d0 := @parameter1: double;	d1 := @parameter2: double;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	r1 = virtualinvoke r7.<java.lang.String: char[] toCharArray()>();	i0 = lengthof r1;	i2 = 0;	if i2 >= i0 goto r8 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	r8 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r2.<org.antlr.v4.gui.PostScriptDocument: void move(double,double)>(d0, d1);	$r5 = r2.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r4 = <java.util.Locale: java.util.Locale US>;	$r3 = newarray (java.lang.Object)[1];	$r3[0] = r8;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r4, "(%s) show\n", $r3);	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	virtualinvoke r2.<org.antlr.v4.gui.PostScriptDocument: void stroke()>();	return
;block_num 3