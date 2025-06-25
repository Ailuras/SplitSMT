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

(declare-sort var3203 0)
(declare-sort var3971 0)
(declare-sort var1252 0)
(declare-sort var3861 0)
(declare-sort var3336 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var1252_newHashMap/701256970 () var3971)
(declare-fun var3861-init () var3861)
(declare-fun <init>/379364885 (var3861) void)
(declare-fun var3971_get/1088891777 (var3971 var3336) var3336)
(declare-fun cast-from-String-to-var3336 (String) var3336)
(declare-fun cast-from-var3336-to-String (var3336) String)
(declare-fun setWord/1927702860 (var3861 String) void)
(declare-fun setLemma/-2044772538 (var3861 String) void)
(declare-fun setTag/-492450796 (var3861 String) void)
(declare-fun setValue/-1305364003 (var3861 String) void)
(declare-fun setOriginalText/-1052378824 (var3861 String) void)
(declare-const null-String String)
(declare-const var3291 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3291 null-String)))
(assert true)
(define-const var3038 Int (length/-134980193 var3291)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2625 Int (- var3038 1)) ; Statement: $i1 = $i0 - 1 
(assert (not (and true (and (>= 1 0) (>= (str.len var3291) var2625) (>= var2625 1)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var1252_newHashMap/701256970=([], java.util.Map), var3861-init=([], edu.stanford.nlp.ling.IndexedWord), <init>/379364885=([edu.stanford.nlp.ling.IndexedWord], void), var3971_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3336=([java.lang.String], java.lang.Object), cast-from-var3336-to-String=([java.lang.Object], java.lang.String), setWord/1927702860=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setLemma/-2044772538=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setTag/-492450796=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setValue/-1305364003=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setOriginalText/-1052378824=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void)}
; {var3291=r0, var3203=null_type, var3038=$i0, var2625=$i1, var964=r1, var2165=r2, var3971=java.util.Map, var1252=edu.stanford.nlp.util.Generics, var415=r3, var1542=i2, var460=i4, var3861=edu.stanford.nlp.ling.IndexedWord, var1412=$r4, var3336=java.lang.Object, var627=$r5, var2035=$r6, var3513=$r7, var2725=$r8, var2658=$r9, var2797=$r10, var2581=$r11, var161=$r12, var2743=$r13, var740=$r14}
; {r0=var3291, null_type=var3203, $i0=var3038, $i1=var2625, r1=var964, r2=var2165, java.util.Map=var3971, edu.stanford.nlp.util.Generics=var1252, r3=var415, i2=var1542, i4=var460, edu.stanford.nlp.ling.IndexedWord=var3861, $r4=var1412, java.lang.Object=var3336, $r5=var627, $r6=var2035, $r7=var3513, $r8=var2725, $r9=var2658, $r10=var2797, $r11=var2581, $r12=var161, $r13=var2743, $r14=var740}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	i2 = lengthof r2;	i4 = 0;	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	$r4 = new edu.stanford.nlp.ling.IndexedWord;	specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>();	$r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word");	$r6 = (java.lang.String) $r5;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6);	$r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma");	$r8 = (java.lang.String) $r7;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8);	$r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS");	$r10 = (java.lang.String) $r9;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10);	$r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value");	$r12 = (java.lang.String) $r11;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12);	$r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current");	$r14 = (java.lang.String) $r13;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14);	return $r4
;block_num 3