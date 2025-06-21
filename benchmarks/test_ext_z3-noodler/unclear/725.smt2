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

(declare-sort var3591 0)
(declare-sort var2065 0)
(declare-sort var387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ps/1203940574 (var3591) String)
(declare-fun arr-var387-init () (Array Int var387))
(declare-fun Float64_valueOf/679560954 (Float64) Float64)
(declare-fun cast-from-Float64-to-var387 (Float64) var387)
(declare-fun String_format/-647569892 (var2065 String (Array Int var387)) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var3591 var3591)
(declare-const null-Float64 Float64)
(declare-const var2065-US var2065)
(declare-const null-__Array__Int__var387__ (Array Int var387))
(declare-const var3321 var3591) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var3321 null-var3591)))
(declare-const var2470 Float64) ; Statement: d0 := @parameter0: double 
(assert (not (= var2470 null-Float64)))
(declare-const var2501 Float64) ; Statement: d1 := @parameter1: double 
(assert (not (= var2501 null-Float64)))
(define-const var2549 String (ps/1203940574 var3321)) ; Statement: $r2 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(define-const var3227 var2065 var2065-US) ; Statement: $r3 = <java.util.Locale: java.util.Locale US> 
(define-const var1071 (Array Int var387) arr-var387-init) ; Statement: $r1 = newarray (java.lang.Object)[2] 
(define-const var3878 Float64 (Float64_valueOf/679560954 var2470)) ; Statement: $r4 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0) 
(declare-const var1071!1 (Array Int var387))
(assert (not (= var1071!1 null-__Array__Int__var387__)))
(assert (= (select var1071!1 0) (cast-from-Float64-to-var387 var3878))) ; Statement: $r1[0] = $r4 
(define-const var430 Float64 (Float64_valueOf/679560954 var2501)) ; Statement: $r5 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d1) 
(declare-const var1071!2 (Array Int var387))
(assert (not (= var1071!2 null-__Array__Int__var387__)))
(assert (= (select var1071!2 1) (cast-from-Float64-to-var387 var430))) ; Statement: $r1[1] = $r5 
(define-const var1489 String (String_format/-647569892 var3227 "%1.3f %1.3f moveto\n" var1071!2)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r3, "%1.3f %1.3f moveto\n", $r1) 
(assert true)
;(assert (append/672562846 var2549 var1489)) ; Statement: virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2549!1 String)
(assert (= var2549!1 (str.++ var2549 var1489)))
 ; Statement: return 
(check-sat)
; {ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), arr-var387-init=([], java.lang.Object[]), Float64_valueOf/679560954=([double], java.lang.Double), cast-from-Float64-to-var387=([java.lang.Double], java.lang.Object), String_format/-647569892=([java.util.Locale, java.lang.String, java.lang.Object[]], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var3591=org.antlr.v4.gui.PostScriptDocument, var3321=r0, var2470=d0, var2501=d1, var2549=$r2, var2065=java.util.Locale, var3227=$r3, var387=java.lang.Object, var1071=$r1, var3878=$r4, var430=$r5, var1489=$r6}
; {org.antlr.v4.gui.PostScriptDocument=var3591, r0=var3321, d0=var2470, d1=var2501, $r2=var2549, java.util.Locale=var2065, $r3=var3227, java.lang.Object=var387, $r1=var1071, $r4=var3878, $r5=var430, $r6=var1489}
;seq <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	d0 := @parameter0: double;	d1 := @parameter1: double;	$r2 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r3 = <java.util.Locale: java.util.Locale US>;	$r1 = newarray (java.lang.Object)[2];	$r4 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0);	$r1[0] = $r4;	$r5 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d1);	$r1[1] = $r5;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r3, "%1.3f %1.3f moveto\n", $r1);	virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	return
;block_num 1