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

(declare-sort var2525 0)
(declare-sort var974 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-fun var974_parseHexValue/533885846 (String Int Int) Int)
(declare-const null-String String)
(declare-const var3842 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3842 null-String)))
(assert true)
(define-const var3578 Int (length/-134980193 var3842)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); } 
(assert (and (not (= var3578 6)) (and (not (= var3578 2)) (and (not (= var3578 1)) true)))) ; Intersect: Negate: Cond: $i0 == 6   and Intersect: Negate: Cond: $i0 == 2   and Intersect: Negate: Cond: $i0 == 1   and Non Conditional   
(assert true)
(define-const var725 Bool (startsWith/-1785782452 var3842 "\u005cu{")) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{") 
 ; Statement: if $z1 == 0 goto $i24 = (int) -1 
(assert (not (= (ite var725 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var229 Int (indexOf/-1037706067 var3842 125)) ; Statement: $i7 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(125) 
(define-const var1691 Int (var974_parseHexValue/533885846 var3842 3 var229)) ; Statement: $i8 = staticinvoke <org.antlr.v4.misc.CharSupport: int parseHexValue(java.lang.String,int,int)>(r0, 3, $i7) 
 ; Statement: return $i8 
(check-sat)
; {length/-134980193=([java.lang.String], int), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), indexOf/-1037706067=([java.lang.String, int], int), var974_parseHexValue/533885846=([java.lang.String, int, int], int)}
; {var3842=r0, var2525=null_type, var3578=$i0, var725=$z1, var229=$i7, var974=org.antlr.v4.misc.CharSupport, var1691=$i8}
; {r0=var3842, null_type=var2525, $i0=var3578, $z1=var725, $i7=var229, org.antlr.v4.misc.CharSupport=var974, $i8=var1691}
;seq <java.lang.String: int length()>;	<java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: int indexOf(int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: int indexOf(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	lookupswitch($i0) {     case 1: goto $c6 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 2: goto $c3 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);     case 6: goto $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u");     default: goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{"); };	$z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("\\u{");	if $z1 == 0 goto $i24 = (int) -1;	$i7 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(125);	$i8 = staticinvoke <org.antlr.v4.misc.CharSupport: int parseHexValue(java.lang.String,int,int)>(r0, 3, $i7);	return $i8
;block_num 3