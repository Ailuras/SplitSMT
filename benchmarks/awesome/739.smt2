(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2928 0)
(declare-sort var1648 0)
(declare-sort var1236 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1648_compile/2141929305 (String) var1648)
(declare-fun helpMessage/377827041 (var2928) String)
(declare-fun matcher/468719934 (var1648 String) var1236)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun find/1809080823 (var1236) Bool)
(declare-fun body/377827041 (var2928) Bool)
(declare-const null-var2928 var2928)
(declare-const var1027 var2928) ; Statement: r0 := @this: org.jline.console.impl.JlineCommandRegistry$HelpLines 
(assert (not (= var1027 null-var2928)))
(define-const var3284 String "") ; Statement: r7 = "" 
(define-const var2438 var1648 (var1648_compile/2141929305 "(^|\u005cn)(Usage|Summary)(:)")) ; Statement: $r2 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("(^|\\n)(Usage|Summary)(:)") 
(define-const var5 String (helpMessage/377827041 var1027)) ; Statement: $r1 = r0.<org.jline.console.impl.JlineCommandRegistry$HelpLines: java.lang.String helpMessage> 
(assert true)
(define-const var936 var1236 (matcher/468719934 var2438 (cast-from-String-to-String var5))) ; Statement: r3 = virtualinvoke $r2.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>($r1) 
(assert true)
(define-const var1379 Bool (find/1809080823 var936)) ; Statement: $z0 = virtualinvoke r3.<java.util.regex.Matcher: boolean find()>() 
 ; Statement: if $z0 == 0 goto $z1 = r0.<org.jline.console.impl.JlineCommandRegistry$HelpLines: boolean body> 
(assert (= (ite var1379 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3983 Bool (body/377827041 var1027)) ; Statement: $z1 = r0.<org.jline.console.impl.JlineCommandRegistry$HelpLines: boolean body> 
 ; Statement: if $z1 != 0 goto $r8 = virtualinvoke r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\r?\\n") 
(assert (not (= (ite var3983 1 0) 0))) ; Cond: $z1 != 0 
; split operation: var335 = var3284.split("\u005cr?\u005cn") ; Statement: $r8 = virtualinvoke r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\r?\\n") 
 ; Statement: return $r8 
(check-sat)
; {var1648_compile/2141929305=([java.lang.String], java.util.regex.Pattern), helpMessage/377827041=([org.jline.console.impl.JlineCommandRegistry$HelpLines], java.lang.String), matcher/468719934=([java.util.regex.Pattern, java.lang.CharSequence], java.util.regex.Matcher), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), find/1809080823=([java.util.regex.Matcher], boolean), body/377827041=([org.jline.console.impl.JlineCommandRegistry$HelpLines], boolean)}
; {var2928=org.jline.console.impl.JlineCommandRegistry$HelpLines, var1027=r0, var3284=r7, var1648=java.util.regex.Pattern, var2438=$r2, var5=$r1, var1236=java.util.regex.Matcher, var936=r3, var1379=$z0, var3983=$z1, var335=$r8}
; {org.jline.console.impl.JlineCommandRegistry$HelpLines=var2928, r0=var1027, r7=var3284, java.util.regex.Pattern=var1648, $r2=var2438, $r1=var5, java.util.regex.Matcher=var1236, r3=var936, $z0=var1379, $z1=var3983, $r8=var335}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.jline.console.impl.JlineCommandRegistry$HelpLines;	r7 = "";	$r2 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("(^|\\n)(Usage|Summary)(:)");	$r1 = r0.<org.jline.console.impl.JlineCommandRegistry$HelpLines: java.lang.String helpMessage>;	r3 = virtualinvoke $r2.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>($r1);	$z0 = virtualinvoke r3.<java.util.regex.Matcher: boolean find()>();	if $z0 == 0 goto $z1 = r0.<org.jline.console.impl.JlineCommandRegistry$HelpLines: boolean body>;	$z1 = r0.<org.jline.console.impl.JlineCommandRegistry$HelpLines: boolean body>;	if $z1 != 0 goto $r8 = virtualinvoke r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\r?\\n");	$r8 = virtualinvoke r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\r?\\n");	return $r8
;block_num 3