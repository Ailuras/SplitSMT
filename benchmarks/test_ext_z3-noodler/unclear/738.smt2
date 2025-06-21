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

(declare-sort var3648 0)
(declare-sort var3982 0)
(declare-sort var1918 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ps/1203940574 (var3648) String)
(declare-fun arr-var1918-init () (Array Int var1918))
(declare-fun Float64_valueOf/679560954 (Float64) Float64)
(declare-fun cast-from-Float64-to-var1918 (Float64) var1918)
(declare-fun String_format/-647569892 (var3982 String (Array Int var1918)) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var3648 var3648)
(declare-const null-Float64 Float64)
(declare-const var3982-US var3982)
(declare-const null-__Array__Int__var1918__ (Array Int var1918))
(declare-const var2316 var3648) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var2316 null-var3648)))
(declare-const var3478 Float64) ; Statement: d0 := @parameter0: double 
(assert (not (= var3478 null-Float64)))
(declare-const var3331 Float64) ; Statement: d1 := @parameter1: double 
(assert (not (= var3331 null-Float64)))
(define-const var1824 String (ps/1203940574 var2316)) ; Statement: $r2 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(define-const var969 var3982 var3982-US) ; Statement: $r3 = <java.util.Locale: java.util.Locale US> 
(define-const var2242 (Array Int var1918) arr-var1918-init) ; Statement: $r1 = newarray (java.lang.Object)[2] 
(define-const var456 Float64 (Float64_valueOf/679560954 var3478)) ; Statement: $r4 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0) 
(declare-const var2242!1 (Array Int var1918))
(assert (not (= var2242!1 null-__Array__Int__var1918__)))
(assert (= (select var2242!1 0) (cast-from-Float64-to-var1918 var456))) ; Statement: $r1[0] = $r4 
(define-const var710 Float64 (Float64_valueOf/679560954 var3331)) ; Statement: $r5 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d1) 
(declare-const var2242!2 (Array Int var1918))
(assert (not (= var2242!2 null-__Array__Int__var1918__)))
(assert (= (select var2242!2 1) (cast-from-Float64-to-var1918 var710))) ; Statement: $r1[1] = $r5 
(define-const var716 String (String_format/-647569892 var969 "%1.3f %1.3f lineto\n" var2242!2)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r3, "%1.3f %1.3f lineto\n", $r1) 
(assert true)
;(assert (append/672562846 var1824 var716)) ; Statement: virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1824!1 String)
(assert (= var1824!1 (str.++ var1824 var716)))
 ; Statement: return 
(check-sat)
; {ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), arr-var1918-init=([], java.lang.Object[]), Float64_valueOf/679560954=([double], java.lang.Double), cast-from-Float64-to-var1918=([java.lang.Double], java.lang.Object), String_format/-647569892=([java.util.Locale, java.lang.String, java.lang.Object[]], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var3648=org.antlr.v4.gui.PostScriptDocument, var2316=r0, var3478=d0, var3331=d1, var1824=$r2, var3982=java.util.Locale, var969=$r3, var1918=java.lang.Object, var2242=$r1, var456=$r4, var710=$r5, var716=$r6}
; {org.antlr.v4.gui.PostScriptDocument=var3648, r0=var2316, d0=var3478, d1=var3331, $r2=var1824, java.util.Locale=var3982, $r3=var969, java.lang.Object=var1918, $r1=var2242, $r4=var456, $r5=var710, $r6=var716}
;seq <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	d0 := @parameter0: double;	d1 := @parameter1: double;	$r2 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r3 = <java.util.Locale: java.util.Locale US>;	$r1 = newarray (java.lang.Object)[2];	$r4 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0);	$r1[0] = $r4;	$r5 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d1);	$r1[1] = $r5;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r3, "%1.3f %1.3f lineto\n", $r1);	virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	return
;block_num 1